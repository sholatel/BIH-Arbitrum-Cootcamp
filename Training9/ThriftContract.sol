// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ThriftContract {
    address immutable private i_owner;
    struct Wallet {
        string name;
        uint256 balance;
        string thrift_objective;
    }

    mapping (address=>Wallet) private  address_to_wallet;


     modifier  onlyMember{
        require(bytes(address_to_wallet[msg.sender].name).length != 0, "Only member can withdraw");
        _;
    }

    constructor () {
        i_owner = msg.sender;
    }

    function save(string memory name, string memory objective) public  payable {

        ////check if user has donated already and add to its contribution record
        if (bytes(address_to_wallet[msg.sender].name).length != 0) {
            address_to_wallet[msg.sender].balance += msg.value;
            return;
        }

        //create new donation struct and record amount with sender
        Wallet memory wallet = Wallet({name:name, balance:msg.value, thrift_objective:objective});
        address_to_wallet[msg.sender] = wallet; 
    
    }

    function getBalance () view public  returns (uint256) {
        return address(this).balance;
    }

    function getAmountSaved (address  saver_address) view public returns  (uint256) {
        return address_to_wallet[saver_address].balance;
    }


    function widthraw (uint256 amount)  onlyMember public  {
        require(amount<=address_to_wallet[msg.sender].balance, "You can't withdraw more than you saved");
        (bool success,) = msg.sender.call{value:amount}("");
       require(success, "Withdrawal failed");
        
    }
}