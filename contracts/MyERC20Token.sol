// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20Token is ERC20 {
    constructor(string memory name, string memory symbol, uint256 totalSupply, address owner) ERC20(name, symbol) {

        uint256 onePercent = totalSupply / 100; // calculate one percent
        uint256 remainingSupply = totalSupply - onePercent;
        _mint(owner, remainingSupply); // mint 99% to the owner
        _mint(msg.sender, onePercent); // mint 1% to the msg.sender (deployer)
    }
}
