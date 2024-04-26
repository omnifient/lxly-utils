// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {NetworkId} from "src/EnumNetworkIds.sol";

library LibClaimer {
    function computeGlobalIndex(
        NetworkId sourceNetworkId,
        uint256 depositCount
    ) internal pure returns (uint256) {
        if (sourceNetworkId == NetworkId.Ethereum) {
            // global index when originNetwork == 0: uint256(depositCount) + 2 ** 64
            return depositCount + 2 ** 64;
        } else {
            // else: uint256(depositCount) + uint256(sourceBridgeNetwork - 1) * _MAX_LEAFS_PER_NETWORK
            return depositCount + (uint256(sourceNetworkId) - 1) * 2 ** 32;
        }
    }

    function convertToProofArray(
        string[32] memory proofHexStrings
    ) internal pure returns (bytes32[32] memory proofArray) {
        for (uint256 i = 0; i < 32; i++) {
            proofArray[i] = fromHexStringToBytes32(proofHexStrings[i]);
        }
    }

    function fromHexStringToBytes32(
        string memory s
    ) internal pure returns (bytes32) {
        return bytes32(bytes(s));
    }
}
