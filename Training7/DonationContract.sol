// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DonationContract { 
    struct Donation {
        string name;
        uint256 amount;
    }

    mapping (address=>Donation) private  address_to_donation;


    function donate(string memory name) public  payable {

        ////check if user has donated already and add to its contribution record
        if (bytes(address_to_donation[msg.sender].name).length != 0) {
            address_to_donation[msg.sender].amount += msg.value;
            return;
        }

        //create new donation struct and record amount with sender
        Donation memory donation = Donation ({name:name, amount:msg.value});
        address_to_donation[msg.sender] = donation; 
    
    }

    function getBalance () view public  returns (uint256) {
        return address(this).balance;
    }

    function getAmountDonatedByDonor (address  donor_address) view public returns  (uint256) {
        return address_to_donation[donor_address].amount;
    }
}