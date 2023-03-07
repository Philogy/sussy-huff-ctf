// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {Test} from "forge-std/Test.sol";
import {HuffDeployer} from "smol-huff-deployer/HuffDeployer.sol";
import {MockERC20} from "./mock/MockERC20.sol";
import {LibString} from "solady/utils/LibString.sol";
import {IChallenge} from "../src/IChallenge.sol";

/// @author philogy <https://github.com/philogy>
contract HackHere is Test {
    MockERC20 token;
    IChallenge challenge;

    address internal immutable tokenOwner = makeAddr("TOKEN_OWNER");
    address internal immutable attackerStartAccount = makeAddr("YOU, THE SOLVER, GOOD LUCK");

    function setUp() public {
        // Deploy contracts
        token = new MockERC20(tokenOwner);
        string[] memory challengeOverrides = new string[](1);
        challengeOverrides[0] = string(abi.encodePacked("TOKEN=", LibString.toHexString(address(token))));
        HuffDeployer deployer = new HuffDeployer();
        challenge = IChallenge(deployer.deploy("./src/Challenge.huff", challengeOverrides, 0));

        // Create deposit to be stolen, give initial balances.
        vm.startPrank(tokenOwner);
        token.approve(address(challenge), type(uint256).max);
        challenge.addToTokenOrder(0.5e18, 999.0e6 * 1e18);
        token.transfer(attackerStartAccount, 1.0e6 * 1e18);
        vm.stopPrank();
        vm.deal(attackerStartAccount, 100 ether);
    }

    function testSolve() external {
        vm.startPrank(attackerStartAccount);
        _executeSolution();
        vm.stopPrank();
        _checkSolved();
    }

    function _executeSolution() internal {
        // Put solution here, no cheat codes
    }

    function _checkSolved() internal {
        assertEq(token.balanceOf(address(challenge)), 0, "Not drained");
    }
}
