// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

/// @author philogy <https://github.com/philogy>
interface IChallenge {
    function addToEthOrder(uint256 price) external payable;
    function refundEthOrder(uint256 price) external;
    function addToTokenOrder(uint256 price, uint256 amount) external;
    function refundTokenOrder(uint256 price) external;
    function getEthOrder(address user, uint256 price) external view returns (uint256);
    function getTokenOrder(address user, uint256 price) external view returns (uint256);
    function matchEthOrder(address ethSeller, address ethBuyer, uint256 price) external;
}
