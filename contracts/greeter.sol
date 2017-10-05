pragma solidity ^0.4.11;

contract Greeter {
    string greeting;
    address owner;
    function Greeter(string _greeting) public {
        owner = msg.sender;
        greeting = _greeting;
    }

    function greet() constant returns (string) {
        return greeting;
    }

    function dispose() { 
      if (msg.sender == owner) 
        selfdestruct(owner); 
    }
}
