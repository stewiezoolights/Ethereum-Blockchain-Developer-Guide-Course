//SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

contract ExceptionExample {

    mapping(address => uint64) public balanceReceived;

    function receiveMoney() public payable {
        assert(msg.value == uint64(msg.value));
        balanceReceived[msg.sender] += uint64(msg.value);    //We are storing the balance in an uint64. Unsigned integers go from 0 to 2^n-1, so that's 2^64-1 or 18446744073709551615.//
        assert(balanceReceived[msg.sender] >= uint64(msg.value));
    }

    function withdrawMoney(address payable _to, uint64 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "Not Enough Funds, aborting");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
        
    }
}
