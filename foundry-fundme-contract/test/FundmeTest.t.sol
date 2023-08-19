//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import  "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

import{DeployFundMe} from "../script/DeployFundme.s.sol";


contract FundmeTest is Test {
    FundMe fundme;

    function setUp() external {
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();
    }

   

    function OwnerIsMsgdotSender() public {
        
          assertEq(fundme.i_owner,msg.sender);
    }



 function VersionIsCorrect() public{

   uint256 version = fundme.getVersion();
   assertEq(version,4); 
 }




   
}
// src/FundMe..sol
