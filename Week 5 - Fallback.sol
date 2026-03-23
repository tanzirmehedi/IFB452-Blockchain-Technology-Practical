// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Fallback {
    event Log(string func, uint gas);

    // Fallback function must be declared as external.
    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        emit Log("fallback", gasleft());
    }

    // Receive is a variant of fallback that is triggered when msg.data is empty
    receive() external payable {
        emit Log("receive", gasleft());
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendToFallback {
    // Allow direct ETH transfers to this contract
    receive() external payable {}

    // Deposit ETH into this contract
    function deposit() public payable {}

    // Check this contract's balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Transfer ETH from this contract's own balance using transfer()
    function transferToFallback(address payable _to, uint _amount) public {
        require(address(this).balance >= _amount, "Insufficient contract balance");
        _to.transfer(_amount);
    }

    // Transfer ETH from this contract's own balance using call()
    function callFallback(address payable _to, uint _amount) public {
        require(address(this).balance >= _amount, "Insufficient contract balance");
        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}
