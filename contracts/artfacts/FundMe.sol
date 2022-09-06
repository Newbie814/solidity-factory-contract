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
          // need to be able to set a minimum fund amount in USD 
          // 1. How do we send ETH to this contract?
        
          require(msg.value.getConversionRate() >= minimumUsd, "Minimum funding amount not met");  // 1e18 = 1 * 10 ** 18 == 1000000000000000000
          funders.push(msg.sender);
          addressToAmountFunded[msg.sender] = msg.value;
      }





    //   function withdraw(){}
}