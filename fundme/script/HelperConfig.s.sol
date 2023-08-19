//  SPDX-license-Identifier: MIT;


pragma solidity ^0.8.9;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

 
   
 // Deploy Mock Framework

    contract HelperConfig is Script{



         struct NetworkConfig{
    address PriceFeed;

  }


NetworkConfig public activeNetworkConfig;

uint8 public constant DECIMALS= 8;
int256 public constant INITIAL_PRICE= 2000e8;


constructor(){
    if(block.chainid == 11155111){

        activeNetworkConfig = getSepoliaEthConfig();}
else{
activeNetworkConfig = getOrCreateAnvilEthConfig();

}
}


   function getSepoliaEthConfig() public pure returns(NetworkConfig memory){
     



          NetworkConfig memory SepoliaConfig=  NetworkConfig({
            PriceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
          });

     return SepoliaConfig;

       }



    function getOrCreateAnvilEthConfig() public  returns(NetworkConfig memory){
      
      /**@dev this condition is to ensure that if
       we have already deployed mock pricefeed we donot redeploy it again */
      
      if(activeNetworkConfig.PriceFeed!= address(0)){
        return activeNetworkConfig;
      }
      
      
      vm.startBroadcast();
      MockV3Aggregator mockPricefeed= new MockV3Aggregator(DECIMALS,INITIAL_PRICE);

      vm.stopBroadcast();

      NetworkConfig memory anvilConfig= NetworkConfig({PriceFeed:address(mockPricefeed)});

      return anvilConfig;

    }
        
    }