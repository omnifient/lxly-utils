// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {IBridge} from "src/IBridge.sol";

// forge script script/Misc.s.sol:GenerateSelector
contract GenerateSelector is Script {
    function run() external view {
        bytes4 selector = bytes4(keccak256("InvalidSmtProof()"));
        console.logBytes4(selector);

        // 0xe0417cec
    }
}

// forge script script/Misc.s.sol:CalculateGlobalExitRoot
contract CalculateGlobalExitRoot is Script {
    function run() external view {
        bytes32 mainnetExitRoot = bytes32(
            bytes(
                hex"439e52bd2a7ded13e07355347c5f6f0c388d0e3ce368f30e0d83177c613d829c"
            )
        );

        bytes32 rollupExitRoot = bytes32(
            bytes(
                hex"cc22b6454fe0b5b893cf680099a2a2f704d778be4f167ffa82afc887ce1d67b7"
            )
        );

        bytes32 ger = keccak256(
            abi.encodePacked(mainnetExitRoot, rollupExitRoot)
        );
        console.logBytes32(ger);

        // 0xdb476386f0c2f44cf1e968be97c361f345c171debf2dfc05e12cd104d2a1eb3d
    }
}

// forge script script/Misc.s.sol:VerifyMerkleProof --rpc-url https://zkevm-rpc.com/ -vvvv
contract VerifyMerkleProof is Script {
    function run() external view {
        bytes memory metadata = bytes(hex"");
        bytes32[32] memory smtProofLocalExitRoot = [
            bytes32(
                bytes(
                    hex"f7ec05ed2f79f01a10cde335560f11d07b1a645dd6c5fbff7377b44b192a7317"
                )
            ),
            bytes32(
                bytes(
                    hex"4b381730e02fad46fef6fb467b9e1d2627d0b106e4a8a6fa2498d5e4e9135b21"
                )
            ),
            bytes32(
                bytes(
                    hex"5c16a60d259287966f03b943e0a2c75c69b9a2d0235a7ac140c29a2b5192e4ec"
                )
            ),
            bytes32(
                bytes(
                    hex"21ddb9a356815c3fac1026b6dec5df3124afbadb485c9ba5a3e3398a04b7ba85"
                )
            ),
            bytes32(
                bytes(
                    hex"3536781e6cae987c57ee7bb931737d29a8ca19bb765180281815733967ec26c7"
                )
            ),
            bytes32(
                bytes(
                    hex"0eb01ebfc9ed27500cd4dfc979272d1f0913cc9f66540d7e8005811109e1cf2d"
                )
            ),
            bytes32(
                bytes(
                    hex"76d1d8956390974633fbc279d6e320c48568f476fdb915fd8fa7263e093ca4e8"
                )
            ),
            bytes32(
                bytes(
                    hex"654b4d6ff63f39909bfa5b7447be80e13fac2199ea775f9553aa7558c2664812"
                )
            ),
            bytes32(
                bytes(
                    hex"964ee094d88d2fdc2c860f62879c4bb71b12e4e2f67b948c7dc4f4d7e602543b"
                )
            ),
            bytes32(
                bytes(
                    hex"2805776c18ae2c4bf4db1f502240cd53a53fe2e82516a954c6806dcd4de10916"
                )
            ),
            bytes32(
                bytes(
                    hex"0f6b459709122e2771f4e4224e12ae21600e9c4ef2e51f7825ff5bc6023aedea"
                )
            ),
            bytes32(
                bytes(
                    hex"34c950316eecce24deeefd4ecf5916b7732aaf8f85f8ec65257150ab2c7c55d3"
                )
            ),
            bytes32(
                bytes(
                    hex"3490c6ceeb450aecdc82e28293031d10c7d73bf85e57bf041a97360aa2c5d99c"
                )
            ),
            bytes32(
                bytes(
                    hex"4fabc9fe01c8f71a973e3647033140a913bc079c663180757558b821d04a10a0"
                )
            ),
            bytes32(
                bytes(
                    hex"5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc"
                )
            ),
            bytes32(
                bytes(
                    hex"a5264b93e3b3779e392e44bc1e4edacc2c298eb275a9fc054e78a34576540149"
                )
            ),
            bytes32(
                bytes(
                    hex"2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f"
                )
            ),
            bytes32(
                bytes(
                    hex"361122b4b1d18ab577f2aeb6632c690713456a66a5670649ceb2c0a31e43ab46"
                )
            ),
            bytes32(
                bytes(
                    hex"5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0"
                )
            ),
            bytes32(
                bytes(
                    hex"b46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0"
                )
            ),
            bytes32(
                bytes(
                    hex"c65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2"
                )
            ),
            bytes32(
                bytes(
                    hex"f4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9"
                )
            ),
            bytes32(
                bytes(
                    hex"5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377"
                )
            ),
            bytes32(
                bytes(
                    hex"4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652"
                )
            ),
            bytes32(
                bytes(
                    hex"cdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef"
                )
            ),
            bytes32(
                bytes(
                    hex"0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d"
                )
            ),
            bytes32(
                bytes(
                    hex"b8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0"
                )
            ),
            bytes32(
                bytes(
                    hex"838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e"
                )
            ),
            bytes32(
                bytes(
                    hex"662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e"
                )
            ),
            bytes32(
                bytes(
                    hex"388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322"
                )
            ),
            bytes32(
                bytes(
                    hex"93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735"
                )
            ),
            bytes32(
                bytes(
                    hex"8448818bb4ae4562849e949e17ac16e0be16688e156b5cf15e098c627c0056a9"
                )
            )
        ];
        bytes32 mainnetExitRoot = bytes32(
            bytes(
                hex"4de6985aef696386995998d02e5d7e8f7ec13d9631fab2243d36f166267955c0"
            )
        );

        IBridge bridge = IBridge(0x2a3DD3EB832aF982ec71669E178424b10Dca2EDe);

        uint256 globalIndex = uint256(176084) + 2 ** 64;
        uint32 leafIndex = uint32(globalIndex);
        bytes32 leafHash = bridge.getLeafValue(
            0, // LEAF_TYPE_ASSET
            0, // origin network
            0x0000000000000000000000000000000000000000, // origin token address
            1, // destination network
            0xbddadBd30b81fB730AA4aD3ac92e933F19cD5F1f, // destination address
            50000000000000000, // amount
            keccak256(metadata)
        );

        bool valid = bridge.verifyMerkleProof(
            leafHash,
            smtProofLocalExitRoot,
            leafIndex,
            mainnetExitRoot
        );
        console.logBool(valid);
    }
}
