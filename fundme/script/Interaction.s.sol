//SPDX-License-Identifier : MIT

// creating a fund script  and a withdraw script
pragma solidity ^0.8.9;

import {Script,console} from "forge-std/scripts.sol";
import {DevOpsTools} from"foundrt-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";
contract FundFundMe is Script{

uint256 constant SEND_VALUE= 0.01 ether;

function fundFundMe(address mostRecentlyDeployed) public {

   FundMe(payable(mostRecentlyDeployed)).fund(value:SEND_VALUE);
   console.log("Funded successfull")

}



 function run() external{
// here we will use devops tools by foundry to get the address of recently deployed contract
address mostRecentlyDeployed= DevOpsTools.get_recent_deployment("FundMe",block.chainid);
  
   vm.startBroadcast();
  fundFundMe(mostRecentlyDeployed);
  vm.stopBroadcast();
 }


}

contract WithdrawFundMe is Script{

    function withdrawFundMe(address mostRecentlyDeployed) public {

   FundMe(payable(mostRecentlyDeployed)).withdraw();
   console.log("Funded successfull")

}



 function run() external{
// here we will use devops tools by foundry to get the address of recently deployed contract
address mostRecentlyDeployed= DevOpsTools.get_recent_deployment("FundMe",block.chainid);
  
   vm.startBroadcast();
  withdrawFundMe(mostRecentlyDeployed);
  vm.stopBroadcast();
 }



}