// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LendContract {
    error FAILED_TO_LEND();

    // address zer = 0x0000000000000000000000000000000000000000

    mapping(address => uint256) loans;

    function lend(address _borrower, uint256 _amount) external payable {
        require(msg.value > 0, "Insufficient amount");
        loans[_borrower] += _amount;
    }

    function repay(uint256 _amount) external {
        assert(loans[msg.sender] >= _amount);

        loans[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function getLoans(address _address) public view returns (uint256) {
        if (_address == address(0)) {
            revert("FAILED_TO_LEND");
        }
        return loans[_address];
    }
}
