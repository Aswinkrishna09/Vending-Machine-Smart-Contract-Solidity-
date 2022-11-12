//SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract VendingMachine {
    address public owner; //20 byte
    mapping(address => uint256) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint256) {
        return donutBalances[address(this)];
    }

    function restock(uint256 _amount) public {
        require(owner == msg.sender, "Only owner can restock the machine");
        donutBalances[address(this)] += _amount;
    }

    function purchase(uint256 _amount) public payable {
        require(
            msg.value >= _amount * 2 ether,
            "You must pay atleast 2 ethers"
        );
        require(donutBalances[address(this)] >= _amount);
        donutBalances[address(this)] -= _amount;
        donutBalances[address(this)] += _amount;
    }
}
