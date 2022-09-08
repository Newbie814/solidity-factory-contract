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

      function fund() public payable {
         
        
          require(msg.value.getConversionRate() >= minimumUsd, "Minimum funding amount not met");  // 1e18 = 1 * 10 ** 18 == 1000000000000000000
          funders.push(msg.sender);
          addressToAmountFunded[msg.sender] = msg.value;
      }





       function withdraw() public {
           // for( starting index, ending index, step amount )
           for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex = funderIndex++ ){
               address funder = funders[funderIndex];
               addressToAmountFunded[funder] = 0;

           }
           funders = new address[](0);       // number in parentheses is just telling how many elements to create array with
               // ways to send native currency from contract:
               // transfer
               // send
               // call


               //transfer: 
               // payable ( msg.sender.transfer(address(this).balance))  // msg.sender is of type address, needed to typecast it to payable, which is of type payable address

               // send:
            //    bool sendSuccess = payable(msg.sender).send(address(this).balance);
            //    require(sendSuccess, 'Send was not completed');

               // call: 
               (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}(""); // returns two variables (noted on left side)
               require(callSuccess, "Call failed");
              
               // commented second variable out, as we don't need it. Left it in for reference. Would normally leave blank, with comma after first variable


       }
}