// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import {Script} from "forge-std/script";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
contract DeployFundMe is Script{

    function run() external returns (fundMe) {
           HelperConfig helperConfig = new HelperConfig();
           address EthPriceFeedAddress= helperConfig.activeNetworkConfig();
            

        vm.startBroadcast();
         FundMe fundMe=new FundMe(activeNetworkConfig);
       
        vm.stopBroadcast();

        return fundMe;
    }

}

