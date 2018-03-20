pragma solidity ^0.4.4;

contract controlTransfer {
  address public owner;
  uint public last_completed_migration;

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function controlTransfer() {
    owner = msg.sender;
  }

  function setCompleted(uint completed) restricted {
    last_completed_migration = completed;
  }

  function upgrade(address new_address) restricted {
    controlTransfer upgraded = controlTransfer(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
