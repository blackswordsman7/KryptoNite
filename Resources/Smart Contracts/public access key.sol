pragma solidity ^0.4.4;

contract showView{
    
    string requestMessage;

    address public owner;
    string public status;
    string public Notes;
    uint public contact;    
    
    
    modifier restricted() {
    if (msg.sender == owner) 
    _;
  }

  function showView() {
    owner = msg.sender;
  }
  
  function info(string req) restricted{
     Notes = req;
  }
  function setStatus(string currentStatus) restricted{
    status = currentStatus;
  }
   function setContact(uint phoneno) restricted{
    contact = phoneno;
  }

  function show() public returns (string, string, uint){
      return (status, Notes, contact);
  }
  
  function message(string mess) {
      requestMessage = mess;
  }
  
  function showAutherised() returns (address, string){
      return (msg.sender, requestMessage);
  }
}
