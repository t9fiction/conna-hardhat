// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./MyERC20Token.sol";

contract Owner {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Owner: caller is not the owner");
        _;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Owner: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Factory is Owner {
    event TokenDeployed(address indexed tokenAddress, string name, string symbol, uint256 totalSupply);
    uint256 public etherFee = 0.03 ether;

    constructor() {}

    function deployToken(string memory name, string memory symbol, uint256 totalSupply) external payable {
        require(msg.value >= etherFee, "Insufficient Ether sent for deployment fee");

        MyERC20Token token = new MyERC20Token(name, symbol, totalSupply, msg.sender);
        emit TokenDeployed(address(token), name, symbol, totalSupply);
    }

    // Owner can withdraw accumulated ether fees
    function withdrawEther() external onlyOwner {
        address payable ownerAddress = payable(owner());
        ownerAddress.transfer(address(this).balance);
    }

    // Function to change the ether fee, only callable by the owner
    function setEtherFee(uint256 newFee) external onlyOwner {
        etherFee = newFee;
    }

    // Owner can withdraw accumulated ERC20 tokens
    function withdrawTokens(address tokenAddress, uint256 amount) external onlyOwner {
        ERC20 token = ERC20(tokenAddress);
        require(token.balanceOf(address(this)) >= amount, "Insufficient token balance");
        token.transfer(owner(), amount);
    }
}
