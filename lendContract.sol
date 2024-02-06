// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LendContract {
    address public lender;
    mapping(address => uint) public loans;

    constructor() {
        lender = msg.sender;
    }

    function lend(address _borrower, uint _amount) external {
        require(msg.sender == lender, "Only lender can lend");
         if (_amount < 0) {
        revert("Failed to lend funds");
       } 
       loans[_borrower] += _amount;
    }

    function repay(uint _amount) external {
        require(loans[msg.sender] >= _amount, "Insufficient loan balance");
        assert(address(this).balance >= _amount); 

        loans[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}

