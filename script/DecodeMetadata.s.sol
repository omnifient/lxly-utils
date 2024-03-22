// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {console} from "forge-std/console.sol";

// forge script script/DecodeMetadata.s.sol:DecodeMetadata
contract DecodeMetadata is Script {
    function run() external view {
        // EURC metadata
        bytes
            memory metadata = hex"000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000094575726f20436f696e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000044555524300000000000000000000000000000000000000000000000000000000";
        console.logBytes(metadata);

        (string memory name, string memory symbol, uint8 decimals) = abi.decode(
            metadata,
            (string, string, uint8)
        );
        console.log("name", name);
        console.log("symbol", symbol);
        console.log("decimals", decimals);
    }
}
