// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { BaseScript } from "script/Base.s.sol";
import { PercentageAllocation } from "src/portfolios/percentageAllocation/PercentageAllocation.sol";
import { IERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/interfaces/IERC20Upgradeable.sol";
import { NameValuePair } from "src/common/Common.sol";

import { console } from "@forge-std/Script.sol";

contract UpgradeWBTCBlueChipScript is BaseScript {
    function run() public virtual broadcast {
        address payable percentageAllocationProxy = payable(address(0x2eAf73F8E6BCf606f56E5cf201756C1f0565C068));
        address calmToken = 0x4d96E1967b13827E5B86A91Ef21a5C1a16a42F75;

        uint256 calmBalance = IERC20Upgradeable(calmToken).balanceOf(broadcaster);

        PercentageAllocation percentageAllocation = PercentageAllocation(percentageAllocationProxy);
        NameValuePair[] memory nvpArray = new NameValuePair[](0);

        IERC20Upgradeable(calmToken).approve(percentageAllocationProxy, calmBalance);
        
        // ===>>> uncomment to withdraw MUST UPGRADE FIRST
        // percentageAllocation.withdraw(calmBalance, 57_687_448_712, broadcaster, nvpArray);
    }
}
