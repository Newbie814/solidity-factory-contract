// SPDX-License-Identifier: MIT

// get funds from users
// withdraw funds 
// set a minimum funding value in USD 

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
      
      uint256 public minimumUsd = 50;

      function fund() public payable {
          // need to be able to set a minimum fund amount in USD 
          // 1. How do we send ETH to this contract?
        
          require(msg.value >= minimumUsd, "Minimum funding amount not met");  // 1e18 = 1 * 10 ** 18 == 1000000000000000000
      }

      // get ETH price
      function getPrice() public {
          // NEED:
          // ABI 
          // Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
          AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
          
      }


      // conversion rate
      function getConversionRate() public {}




    //   function withdraw(){}
}