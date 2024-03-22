// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {LibPolygonZkEVMBridgeV2} from "src/LibPolygonZkEVMBridgeV2.sol";

// forge script script/EncodeMetadata.s.sol:EncodeMetadata --rpc-url https://rpc.flashbots.net -vvvvv
// forge script script/EncodeMetadata.s.sol:EncodeMetadata --rpc-url https://zkevm-rpc.com -vvvvv
contract EncodeMetadata is Script {
    function run() external view returns (bytes memory metadata) {
        address token = 0x1aBaEA1f7C830bD89Acc67eC4af516284b1bC33c; // L1 EUR

        // generate intermediary metadata values
        string memory safeName = LibPolygonZkEVMBridgeV2.safeName(token);
        string memory safeSymbol = LibPolygonZkEVMBridgeV2.safeSymbol(token);
        uint8 safeDecimals = LibPolygonZkEVMBridgeV2.safeDecimals(token);
        console.log("token address", token);
        console.log("safe name", safeName);
        console.log("safe symbol", safeSymbol);
        console.log("safe decimals", safeDecimals);

        // the core: generate metadata
        metadata = LibPolygonZkEVMBridgeV2.getTokenMetadata(token);
        console.logBytes(metadata);
    }
}
