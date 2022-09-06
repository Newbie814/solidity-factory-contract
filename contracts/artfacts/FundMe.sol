// SPDX-License-Identifier: MIT

// get funds from users
// withdraw funds 
// set a minimum funding value in USD 

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
      
      uint256 public minimumUsd = 50 * 1e18;

      address[] public funders;
      mapping(address => uint256) public addressToAmountFunded;

      function fund() public payable {
          // need to be able to set a minimum fund amount in USD 
          // 1. How do we send ETH to this contract?
        
          require(getConversionRate(msg.value) >= minimumUsd, "Minimum funding amount not met");  // 1e18 = 1 * 10 ** 18 == 1000000000000000000
          funders.push(msg.sender);
          addressToAmountFunded[msg.sender] = msg.value;
      }

      // get ETH price
      function getPrice() public view returns (uint256) {
          // NEED:
          // ABI 
          // Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
          AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
          (, int256 price,,,) =  priceFeed.latestRoundData();

          return uint256(price * 1e10); // 1**10 == 10000000000

      }

      function getVersion() public view returns (uint256) {
          AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
          return priceFeed.version();
      }


      // conversion rate
      function getConversionRate(uint256 ethAmount) public view returns (uint256) {
          uint256 ethPrice = getPrice();
          uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
          return ethAmountInUsd;
      }




    //   function withdraw(){}
}