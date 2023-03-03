// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {ERC20} from "oz/token/ERC20/ERC20.sol";

/// @author philogy <https://github.com/philogy>
contract MockERC20 is ERC20("Mock", "MCK") {
    constructor(address _initialOwner) {
        _mint(_initialOwner, 1e9 * 1e18);
    }
}
