// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// A simple arithmetic smart contract deployed to  Arbitrum Sepolia to find an odd number, an even number, and most significant bits.

contract SimpleArithmetic {
    
    function findNumberType (uint256 number)  pure  public returns (string memory)  {
       
        uint256  remainder =  number % 2;

        if (remainder==0) {
            return "Even";
        }
        else {
            return "Odd";
        }
    }

    function  mSignificantBit (uint256 number ) pure public  returns (uint) {
        uint256 index = 0; uint256 count = 0;
        while(number != 0) {
            count++;
            if(number % 2 == 1) {
                index = count;
            }
            number /= 2;
        }
        return (1 << (index - 1));
    }

    
}