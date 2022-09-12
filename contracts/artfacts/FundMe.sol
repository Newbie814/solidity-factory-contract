// SPDX-License-Identifier: MIT

// get funds from users
// withdraw funds 
// set a minimum funding value in USD 

pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error NotOwner();
error MinEthReqFail();
error CallFail();

contract FundMe {
      
      using PriceConverter for uint256;
      
      uint256 public constant MINIMUM_USD = 50 * 10 ** 18;

      address[] public funders;
      mapping(address => uint256) public addressToAmountFunded;

      address public immutable i_owner;

        modifier onlyOwner {
           //require(msg.sender == i_owner, "Sender is not the owner of this contract");
           if(msg.sender != i_owner) {revert NotOwner();}
           _;
       }


      constructor () {
          i_owner = msg.sender;

      }

      function fund() public payable {
        // require(msg.value.getConversionRate() >= MINIMUM_USD, "Transaction does not meet the minimom ETH requirements.");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        if(msg.value.getConversionRate() < MINIMUM_USD) {revert MinEthReqFail();}
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }


     


       function withdraw() public onlyOwner {
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        // require(callSuccess, "Call failed");
        if(!callSuccess) {revert CallFail();}
    }

      
}    