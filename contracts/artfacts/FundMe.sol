// SPDX-License-Identifier: MIT

// get funds from users
// withdraw funds 
// set a minimum funding value in USD 

pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract FundMe {
      
      using PriceConverter for uint256;
      
      uint256 public minimumUsd = 50 * 1e18;

      address[] public funders;
      mapping(address => uint256) public addressToAmountFunded;

      address public owner;

      constructor () {
          owner = msg.sender;

      }

      function fund() public payable {
         
        
          require(msg.value.getConversionRate() >= minimumUsd, "Minimum funding amount not met");  // 1e18 = 1 * 10 ** 18 == 1000000000000000000
          funders.push(msg.sender);
          addressToAmountFunded[msg.sender] = msg.value;
      }





       function withdraw() public onlyOwner {
           

           // for( starting index, ending index, step amount )
           for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex++ ){
               address funder = funders[funderIndex];
               addressToAmountFunded[funder] = 0;

           }
           //reset array
           funders = new address[](0);      
               (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}(""); 
               require(callSuccess, "Call failed");

       }

       modifier onlyOwner {
           require(msg.sender == owner, "Sender is not the owner of this contract");
           _;
       }
}