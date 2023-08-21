//SPDX-license-Identifier:MIT

pragma solidity ^0.8.9;

import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe } from "../../script/DeoployFundMe.s.sol";
import {FundFundMe,WithdrawFundMe} from "../../script/Interactions.sol"; 

contract FundMeTestIntegration is Test{

 FundMe fundMe;
    address USER= makeAddr("user");
    uint256 constant SEND_VALUE= 0.1 ether;
    uint256 constant STARTING_BALANCE=10 ether;
    uint256 constant GAS_PRICE=1;
function setUp() external {
    DeployFundMe deployFundMe = new DeployFundMe();

     fundMe = deployFundMe.run();
     vm.deal(USER,STARTING_BALANCE);

}


function testUserCanFund() public {

    FundFundMe fundFundMe = new FundFundMe();
    vm.prank(USER);
    vm.deal(USER,1e18);
    fundFundMe.fundFundMe(address(fundMe));
    
    WithdrawFundMe withdrawFundMe = new WithdrawFund;
    withdrawFundMe.withdrawFundMe(address(fundMe));

    address funder=fundMe.getFunder(0);
    assert(address(fundMe).balance ==0);
    

}

}