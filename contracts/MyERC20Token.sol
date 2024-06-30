// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20Token is ERC20 {
    constructor(string memory name, string memory symbol, uint256 totalSupply, address owner) ERC20(name, symbol) {
        _mint(owner, totalSupply);
    }
}
