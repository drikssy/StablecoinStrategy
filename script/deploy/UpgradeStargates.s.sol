// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "script/Base.s.sol";
import { Stargate } from "src/strategies/stargate/Stargate.sol";
import { console } from "@forge-std/Script.sol";

contract UpgradeStargateUsdtScript is BaseScript {
    function run() public virtual broadcast {
        address payable stargateUsdtProxyAddress = payable(address(0xc802921c1557C96e6ba40CfD219e8F825BD34D84));

        Stargate stargateProxy = Stargate(stargateUsdtProxyAddress);
        Stargate newImplementation = new Stargate();
        console.log("new Stargate Implementation address deployed at: %s", address(newImplementation));

        console.log("Upgrading Stargate contract");
        stargateProxy.upgradeTo(address(newImplementation));
        console.log("Stargate contract upgraded to new implementation");
        console.log("Stargate proxy still at address: %s", address(stargateProxy));
    }
}
