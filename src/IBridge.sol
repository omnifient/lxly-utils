// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

import {IPolygonZkEVMBridgeV2} from "@zkevm/v2/interfaces/IPolygonZkEVMBridgeV2.sol";

interface IBridge is IPolygonZkEVMBridgeV2 {
    // uint256 internal constant _DEPOSIT_CONTRACT_TREE_DEPTH = 32;

    function tokenInfoToWrappedToken(
        bytes32 tokenInfoHash
    ) external view returns (address);

    function getLeafValue(
        uint8 leafType,
        uint32 originNetwork,
        address originAddress,
        uint32 destinationNetwork,
        address destinationAddress,
        uint256 amount,
        bytes32 metadataHash
    ) external pure returns (bytes32);

    function verifyMerkleProof(
        bytes32 leafHash,
        bytes32[32] calldata smtProof,
        uint32 index,
        bytes32 root
    ) external pure returns (bool);
}
