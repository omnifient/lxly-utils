// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {console} from "forge-std/console.sol";

import {IBridge} from "src/IBridge.sol";
import {NetworkId} from "src/EnumNetworkIds.sol";
import {LibClaimer} from "src/LibClaimer.sol";
import {Testnet} from "src/LibConstants.sol";

// https://cardona-zkevm.polygonscan.com/tx/0xe414c297d4b69b82b72b09eedf05592b07a2410d0805d6c5a74968eb48d261e0#eventlog
//
// export RPC=https://rpc.cardona.zkevm-rpc.com
// forge script script/ClaimAsset.s.sol:ClaimAsset --legacy --rpc-url ${RPC} -vvvv
// forge script script/ClaimAsset.s.sol:ClaimAsset --legacy --rpc-url ${RPC} -vvvv --broadcast
contract ClaimAsset is Script {
    function run() public {
        //         NetworkId originNetwork = NetworkId.PolygonZkEVM;
        //         NetworkId destinationNetwork = NetworkId.Astar;
        //         address tokenOriginAddr = 0x88342beb50513C9994696C1DadEedaD5e8b763DF;
        //         address destinationAddr = 0x9afd1f29eaBd2B344321c2bB25B8ff855edE930B;
        //         uint256 depositCount = 7265;
        //         uint256 amount = 8000000000000000000000;
        //         string
        //             memory mainnetExitRoot = "0xb71979a7032c35d54fa0255a5f3a254014dcd4f4edbb5dff737d843110c2422d";
        //         string
        //             memory rollupExitRoot = "0x38d7226a7a53c364a856c5eed1340bcb5908553dc757f4cca08e077ac9515555";
        //         string
        //             memory metadata = "000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000001200000000000000000000000000000000000000000000000000000000000000174167677265676174696f6e204c6179657220546f6b656e00000000000000000000000000000000000000000000000000000000000000000000000000000000034147470000000000000000000000000000000000000000000000000000000000";
        //         string[32] memory localProofHexStrings = [
        //             "0xf0e4b72c3d99dfde77c1b3297e09dc5f9a4034e6ece6ea3320fc3459c6410f3f",
        //             "0x66117bc099e5868c8a2406556600ebbca2815db7224f5443bcfb09f1d6019db2",
        //             "0xd2df84182f284ec7a05f22660e4e1ada0da66d84ed66f9788d86ec989f3a74b8",
        //             "0xd15b5fa3e5bf8d553d950ef5a5586532841b8dc519f08cb5540bba67f75e0f5b",
        //             "0x7b5b764558ad8fef4fdc2f82d9ffc6cb87c887f882276a3e04585639f34a927a",
        //             "0x0934dde0f0e0c34373b3fa478ab1efdc7fc089e12629751b0f4d780af00fc298",
        //             "0xd7454b5521f1f1883324eb6c06006b3d8b956452a7051e9abae4ca1a657abd82",
        //             "0x2446491af04288d962368b825c6e9f20d5fe6007053d6807524a7968b27e619b",
        //             "0x9867cc5f7f196b93bae1e27e6320742445d290f2263827498b54fec539f756af",
        //             "0xcefad4e508c098b9a7e1d8feb19955fb02ba9675585078710969d3440f5054e0",
        //             "0xf03fe499a9f8fb0b8841e382e7da988bfa0d849cb286bfeb0bdca44f63dbd174",
        //             "0x7c06ee11d51bd1145f8146046723168d95cdb65623ea522d173a1dacfa8c237c",
        //             "0x460d5146595c7845d7cf35c5c9caa42968508d19db2b97b20468406de1bd7fa7",
        //             "0xc1df82d9c4b87413eae2ef048f94b4d3554cea73d92b0f7af96e0271c691e2bb",
        //             "0x5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc",
        //             "0xda7bce9f4e8618b6bd2f4132ce798cdc7a60e7e1460a7299e3c6342a579626d2",
        //             "0x2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f",
        //             "0xe1d3b5c807b281e4683cc6d6315cf95b9ade8641defcb32372f1c126e398ef7a",
        //             "0x5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0",
        //             "0xb46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0",
        //             "0xc65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2",
        //             "0xf4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9",
        //             "0x5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377",
        //             "0x4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652",
        //             "0xcdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef",
        //             "0x0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d",
        //             "0xb8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0",
        //             "0x838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e",
        //             "0x662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e",
        //             "0x388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322",
        //             "0x93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735",
        //             "0x8448818bb4ae4562849e949e17ac16e0be16688e156b5cf15e098c627c0056a9"
        //         ];
        //         string[32] memory rollupProofHexStrings = [
        //             "0x4a2a2822c75ad8ccdc2a1e1cb965d2c7c848afc0c7471f79b210107e620834ad",
        //             "0xaf765ef48a4bf87890205e2cec51236bbb64829ee13401bba8ed93df90b2ab9a",
        //             "0xeb91d626dcfcad0991f3aac7b4ac864b45c1bf2c388e2a1ec70a4722a058baf9",
        //             "0xd47d418be40d7efe899adcacac00c142a57aa5ee76556b2ce440247506049d9b",
        //             "0xe58769b32a1beaf1ea27375a44095a0d1fb664ce2dd358e7fcbfb78c26a19344",
        //             "0x0eb01ebfc9ed27500cd4dfc979272d1f0913cc9f66540d7e8005811109e1cf2d",
        //             "0x887c22bd8750d34016ac3c66b5ff102dacdd73f6b014e710b51e8022af9a1968",
        //             "0xffd70157e48063fc33c97a050f7f640233bf646cc98d9524c6b92bcf3ab56f83",
        //             "0x9867cc5f7f196b93bae1e27e6320742445d290f2263827498b54fec539f756af",
        //             "0xcefad4e508c098b9a7e1d8feb19955fb02ba9675585078710969d3440f5054e0",
        //             "0xf9dc3e7fe016e050eff260334f18a5d4fe391d82092319f5964f2e2eb7c1c3a5",
        //             "0xf8b13a49e282f609c317a833fb8d976d11517c571d1221a265d25af778ecf892",
        //             "0x3490c6ceeb450aecdc82e28293031d10c7d73bf85e57bf041a97360aa2c5d99c",
        //             "0xc1df82d9c4b87413eae2ef048f94b4d3554cea73d92b0f7af96e0271c691e2bb",
        //             "0x5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc",
        //             "0xda7bce9f4e8618b6bd2f4132ce798cdc7a60e7e1460a7299e3c6342a579626d2",
        //             "0x2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f",
        //             "0xe1d3b5c807b281e4683cc6d6315cf95b9ade8641defcb32372f1c126e398ef7a",
        //             "0x5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0",
        //             "0xb46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0",
        //             "0xc65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2",
        //             "0xf4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9",
        //             "0x5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377",
        //             "0x4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652",
        //             "0xcdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef",
        //             "0x0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d",
        //             "0xb8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0",
        //             "0x838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e",
        //             "0x662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e",
        //             "0x388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322",
        //             "0x93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735",
        //             "0x8448818bb4ae4562849e949e17ac16e0be16688e156b5cf15e098c627c0056a9"
        //         ];
        //         vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        //         _claimAsset(
        //             Testnet.BRIDGE,
        //             localProofHexStrings,
        //             rollupProofHexStrings,
        //             originNetwork,
        //             destinationNetwork,
        //             depositCount,
        //             tokenOriginAddr,
        //             destinationAddr,
        //             mainnetExitRoot,
        //             rollupExitRoot,
        //             amount,
        //             metadata
        //         );
        //         vm.stopBroadcast();
        //     }
        //     // helper to get rid of stack too deep
        //     function _claimAsset(
        //         address bridge,
        //         string[32] memory localProofHexStrings,
        //         string[32] memory rollupProofHexStrings,
        //         NetworkId originNetwork,
        //         NetworkId destinationNetwork,
        //         uint256 depositCount,
        //         address tokenOriginAddr,
        //         address destinationAddr,
        //         string memory mainnetExitRoot,
        //         string memory rollupExitRoot,
        //         uint256 amount,
        //         string memory metadata
        //     ) internal {
        //         IBridge(bridge).claimMessage(
        //             LibClaimer.convertToProofArray(localProofHexStrings),
        //             LibClaimer.convertToProofArray(rollupProofHexStrings),
        //             LibClaimer.computeGlobalIndex(originNetwork, depositCount),
        //             LibClaimer.fromHexStringToBytes32(mainnetExitRoot),
        //             LibClaimer.fromHexStringToBytes32(rollupExitRoot),
        //             uint32(originNetwork),
        //             tokenOriginAddr,
        //             uint32(destinationNetwork),
        //             destinationAddr,
        //             amount,
        //             bytes(metadata)
        //         );
    }
}
