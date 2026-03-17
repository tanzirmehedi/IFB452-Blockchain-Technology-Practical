// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GasExample {

    uint public total;

    // This function consumes gas when called
    function addNumber(uint x) public {

        uint startGas = gasleft();   // Gas available at start

        total += x;                  // Operation that costs gas

        uint endGas = gasleft();     // Gas remaining after execution

        uint gasUsed = startGas - endGas;

        // Store the gas used in the transaction
        lastGasUsed = gasUsed;
    }

    uint public lastGasUsed;

    // Returns transaction fee estimation
    function estimateTransactionFee(uint gasPrice) public view returns(uint) {
        return lastGasUsed * gasPrice;
    }
}