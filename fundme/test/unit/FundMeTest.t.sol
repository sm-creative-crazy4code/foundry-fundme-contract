//SPDX-license-Identifier:MIT

pragma solidity ^0.8.9;

import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe } from "../../script/DeoployFundMe.s.sol";

contract FundMeTest is Test{
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

function checkMiniumDollarsIsFived() public {
    assertEq(fundMe.MINIMUM_USD, 5e18);

}

function testOwerIsMsgSender() public{
    assertEq(fundMe.i_owner, msg,sender);

}


function TestPricefeedVersionIsAccurate() public{
    uint version= fundMe.getVersion();
    assertEq(version,4);
}


function TestFundFailsWithoutEnoughEthos() public{

vm.expectRevert();
fundMe.fund();



}


function testFundsUpdatesDataStructure() public{
    vm.prank(USER);
    fundMe.fund{value:SEND_VALUE}();
    uint256 amountFunded=fundMe.getAddressToAmountFunded(USER);
    assertEq(amountFunded,SEND_VALUE);
}

function testAddFunderToArray() public{
    vm.prank(USER);
    fundMe.fund{value:SEND_VALUE}();
    address funder=fundMe.getFunder(0);
    assertEq(funder,USER);


}


modifier funded(){
    vm.prank(USER);
 fundMe.fund{value:SEND_VALUE}();

 _;

}

function testOnlyUserCanWithDraw() public funded{
 
 vm.prank(USER);
 vm.expectRevert();
 fundMe.withdraw();

}



function testWithdrawWithAsingleFunder() publiv funded{

    // Arrange
    uint256 startingOwnerBalance= fundMe.getOwner().balance;
    uint256 startingFundmeBalance= address(fundMe).balance;
    
    // Act
    uint256 gasStart= gasleft();//returns the gas left
    vm.txGasPrice(GAS_PRICE);
    vm.prank(fundMe.getOwner());
    fundMe.withdraw();

    
    
    uint256 gasEnd= gasleft(); //returns gas left after txn
    uint256 gasUsed=(gasStart-gasEnd)*tx.gasprice;
    // Assert

    uint256 endingOwnerBalance= fundMe.getOwner().balance;
    uint256 endingFundMeBalance= address(fundMe).balance;
    assertEq(endingFundMeBalance,0);
    assertEq(startFundMeBalance+startingOwnerBalance,endingOwnerBalance);
}


test TestWithdrawWithManyFunders() publc{
uint160 numberOfFunders = 10;
uint160 startingFunderIndex = 1;

for (uint160 i =startingFunderIndex; i < numberOfFunders; i++) {
    hoax(address(i),SEND_VALUE);
    fundMe.fund(value:SEND_VALUE);

}

uint256 staringOwnerBalance= fundMe.getOwner().balance;
uint256 startingFundMeBalance= address(fundMe).balance;

vm.txGasPrice(GAS_PRICE);
vm.startPrank(fundMe.getOwner());
fundMe.withdraw();
vm.stopPrank();

assertEq(address(fundMe).balance,0);
assertEq(startingFundMeBalance+startingOwnerBalance,fundMw.getOwner().balance);

}


test TestWithdrawWithManyFundersCheaper() publc{
uint160 numberOfFunders = 10;
uint160 startingFunderIndex = 1;

for (uint160 i =startingFunderIndex; i < numberOfFunders; i++) {
    hoax(address(i),SEND_VALUE);
    fundMe.fund(value:SEND_VALUE);

}

uint256 staringOwnerBalance= fundMe.getOwner().balance;
uint256 startingFundMeBalance= address(fundMe).balance;

vm.txGasPrice(GAS_PRICE);
vm.startPrank(fundMe.getOwner());
fundMe.cheaperWithdraw();
vm.stopPrank();

assertEq(address(fundMe).balance,0);
assertEq(startingFundMeBalance+startingOwnerBalance,fundMw.getOwner().balance);

}





}