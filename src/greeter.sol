pragma solidity ^0.4.11;

contract Disposable {
    address owner;
    function Disposable() {
      owner = msg.sender; 
    }

    function dispose() { 
      if (msg.sender == owner) 
        selfdestruct(owner); 
    }
}

contract Greeter is Disposable {
    string greeting;
    
    function Greeter(string _greeting) public {
        greeting = _greeting;
    }

    function greet() constant returns (string) {
        return greeting;
    }
}
