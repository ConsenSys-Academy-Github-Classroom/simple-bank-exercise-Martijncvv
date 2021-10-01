/*
 * This exercise has been updated to use Solidity version 0.8.5
 * See the latest Solidity updates at
 * https://solidity.readthedocs.io/en/latest/080-breaking-changes.html
 */
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16 <0.9.0;

contract SimpleBank {

    mapping (address => uint) private balances;
    mapping (address => bool) public enrolled;

    address public owner = msg.sender;
    
    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);


    function () external payable {
      revert();
    }

    function getBalance() public view returns (uint) {
      return balances[msg.sender];
    }

    function enroll() public returns (bool){
      enrolled[msg.sender] = true;
      emit LogEnrolled(msg.sender);
      return true;
    }

    function deposit() public payable returns (uint) {
      require(enrolled[msg.sender]);

      balances[msg.sender] += msg.value;
      emit LogDepositMade(msg.sender, msg.value);
      return(balances[msg.sender]);
    }

    function withdraw(uint withdrawAmount) public returns (uint) {
      require(balances[msg.sender] >= withdrawAmount);

      balances[msg.sender] -= withdrawAmount;
      emit LogWithdrawal(msg.sender, withdrawAmount, balances[msg.sender]);
      return balances[msg.sender];
    }
}
