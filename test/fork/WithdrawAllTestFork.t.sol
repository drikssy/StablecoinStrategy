// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Fork_Test } from "./Fork.t.sol";
import { IERC20Upgradeable } from "@openzeppelin/contracts-upgradeable/interfaces/IERC20Upgradeable.sol";
import { PercentageAllocation } from "src/portfolios/percentageAllocation/PercentageAllocation.sol";
import { NameValuePair } from "src/common/Common.sol";
import { IInvestable } from "src/common/interfaces/IInvestable.sol";
import { Stargate } from "src/strategies/stargate/Stargate.sol";

import { console } from "@forge-std/console.sol";

contract WithdrawAllTestFork is Fork_Test {
    address from = payable(address(0xD494Ea7b6E64069b18B5c223b99E9d7C6f2B266C));
    address payable percentageAllocationProxy = payable(address(0x2eAf73F8E6BCf606f56E5cf201756C1f0565C068));
    address owner = address(0xE8855828fEC29dc6860A4362BCb386CCf6C0c601);
    address calmToken = 0x4d96E1967b13827E5B86A91Ef21a5C1a16a42F75;
    address usdcAddress = 0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E;

    address receiver = makeAddr("receiver");

    function test_withdrawAll() public {
        NameValuePair[] memory nvpArray = new NameValuePair[](0);
        PercentageAllocation percentageAllocation = PercentageAllocation(percentageAllocationProxy);
        uint256 calmBalance = IERC20Upgradeable(calmToken).balanceOf(owner);
        Stargate sg = Stargate(0xc802921c1557C96e6ba40CfD219e8F825BD34D84);

        vm.startPrank(0x0625Db97368dF1805314E68D0E63e5eB154B9AE6);
        Stargate implem = new Stargate();
        sg.upgradeTo(address(implem));

        uint256 usdcBalanceBF = IERC20Upgradeable(usdcAddress).balanceOf(owner);
        uint256 usdtBalanceBF = IERC20Upgradeable(sg.USDT_ADDRESS()).balanceOf(owner);

        // percentageAllocation.setTargetInvestableAllocations(percentages);
        // // percentageAllocation.removeInvestable(IInvestable(0x8f723a11C674cab9BA4C71Bb5df3c519Eea0fD0a), p);
        // percentageAllocation.removeInvestable(IInvestable(0xe203647cC2b89860735aE191F13DE44749Cd37C8), p);
        // percentageAllocation.removeInvestable(IInvestable(0x69C8367bfe0DD9B26284617353B58319241A6763), _p);
        // vm.stopPrank();

        vm.startPrank(owner);
        // IERC20Upgradeable(usdc).approve(percentageAllocationProxy, 10_000 * 10 ** 6);
        // percentageAllocation.deposit(10 * 10 ** 6, 0, depositUser, nvpArray);
        IERC20Upgradeable(calmToken).approve(percentageAllocationProxy, calmBalance);
        percentageAllocation.withdraw(calmBalance, 0, owner, nvpArray);
        vm.stopPrank();

        uint256 usdcBalanceAF = IERC20Upgradeable(usdcAddress).balanceOf(owner);
        uint256 usdtBalanceAF = IERC20Upgradeable(sg.USDT_ADDRESS()).balanceOf(owner);

        console.log("usdcBalanceRecived: ", usdcBalanceAF - usdcBalanceBF);
        console.log("usdtBalanceRecived: ", usdtBalanceAF - usdtBalanceBF);
    }

    // function test_upgradeTo_andWithdrawAll() public {
    //     WBTCBluechip wBTCBluechip = WBTCBluechip(wBTCBluechipProxyAddress);
    //     WBTCBluechip newImplementation = new WBTCBluechip();
    //     (IERC20Upgradeable blueChipToken,) = wBTCBluechip.bluechipTokenInfo();
    //     uint256 balanceBeforeWithdraw = blueChipToken.balanceOf(wBTCBluechipProxyAddress);
    //     uint256 receiverBalanceBeforeWithdraw = blueChipToken.balanceOf(receiver);

    //     vm.startPrank(wBTCBluechipOwner);
    //     wBTCBluechip.upgradeTo(address(newImplementation));
    //     wBTCBluechip.withdrawToReceiver(receiver);
    //     vm.stopPrank();

    //     uint256 balanceAfterWithdraw = blueChipToken.balanceOf(wBTCBluechipProxyAddress);
    //     uint256 receiverBalanceAfterWithdraw = blueChipToken.balanceOf(receiver);

    //     assertEq(balanceAfterWithdraw, 0);
    //     assertEq(receiverBalanceAfterWithdraw, balanceBeforeWithdraw + receiverBalanceBeforeWithdraw);
    // }
}
