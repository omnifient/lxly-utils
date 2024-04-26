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
// export RPC=https://rpc.startale.com/zkyoto
// forge script script/ClaimMessage.s.sol:ClaimMessage --rpc-url ${RPC} -vvvvv
// forge script script/ClaimMessage.s.sol:ClaimMessage --rpc-url ${RPC} -vvvvv --broadcast
contract ClaimMessage is Script {
    function run() public {
        NetworkId originNetwork = NetworkId.PolygonZkEVM;
        NetworkId destinationNetwork = NetworkId.Astar;
        address originAddr = 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1;
        address destinationAddr = 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1;
        uint256 depositCount = 7266;
        string[32] memory localProofHexStrings = [
            hex"f0e4b72c3d99dfde77c1b3297e09dc5f9a4034e6ece6ea3320fc3459c6410f3f",
            hex"cd542048fa18d527fa5e59c6421a3a52912c42ce4d2b4a9079c49d847b6e7291",
            hex"d2df84182f284ec7a05f22660e4e1ada0da66d84ed66f9788d86ec989f3a74b8",
            hex"d15b5fa3e5bf8d553d950ef5a5586532841b8dc519f08cb5540bba67f75e0f5b",
            hex"7b5b764558ad8fef4fdc2f82d9ffc6cb87c887f882276a3e04585639f34a927a",
            hex"0934dde0f0e0c34373b3fa478ab1efdc7fc089e12629751b0f4d780af00fc298",
            hex"d7454b5521f1f1883324eb6c06006b3d8b956452a7051e9abae4ca1a657abd82",
            hex"145ba507b0be3f3f7c6a7e5805f8c4ab355b52be9c85b3a1abd91b2f9735ffd6",
            hex"9867cc5f7f196b93bae1e27e6320742445d290f2263827498b54fec539f756af",
            hex"cefad4e508c098b9a7e1d8feb19955fb02ba9675585078710969d3440f5054e0",
            hex"f03fe499a9f8fb0b8841e382e7da988bfa0d849cb286bfeb0bdca44f63dbd174",
            hex"7c06ee11d51bd1145f8146046723168d95cdb65623ea522d173a1dacfa8c237c",
            hex"460d5146595c7845d7cf35c5c9caa42968508d19db2b97b20468406de1bd7fa7",
            hex"c1df82d9c4b87413eae2ef048f94b4d3554cea73d92b0f7af96e0271c691e2bb",
            hex"5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc",
            hex"da7bce9f4e8618b6bd2f4132ce798cdc7a60e7e1460a7299e3c6342a579626d2",
            hex"2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f",
            hex"e1d3b5c807b281e4683cc6d6315cf95b9ade8641defcb32372f1c126e398ef7a",
            hex"5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0",
            hex"b46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0",
            hex"c65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2",
            hex"f4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9",
            hex"5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377",
            hex"4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652",
            hex"cdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef",
            hex"0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d",
            hex"b8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0",
            hex"838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e",
            hex"662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e",
            hex"388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322",
            hex"93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735",
            hex"8448818bb4ae4562849e949e17ac16e0be16688e156b5cf15e098c627c0056a9"
        ];
        string[32] memory rollupProofHexStrings = [
            hex"4a2a2822c75ad8ccdc2a1e1cb965d2c7c848afc0c7471f79b210107e620834ad",
            hex"af765ef48a4bf87890205e2cec51236bbb64829ee13401bba8ed93df90b2ab9a",
            hex"eb91d626dcfcad0991f3aac7b4ac864b45c1bf2c388e2a1ec70a4722a058baf9",
            hex"d47d418be40d7efe899adcacac00c142a57aa5ee76556b2ce440247506049d9b",
            hex"e58769b32a1beaf1ea27375a44095a0d1fb664ce2dd358e7fcbfb78c26a19344",
            hex"0eb01ebfc9ed27500cd4dfc979272d1f0913cc9f66540d7e8005811109e1cf2d",
            hex"887c22bd8750d34016ac3c66b5ff102dacdd73f6b014e710b51e8022af9a1968",
            hex"ffd70157e48063fc33c97a050f7f640233bf646cc98d9524c6b92bcf3ab56f83",
            hex"9867cc5f7f196b93bae1e27e6320742445d290f2263827498b54fec539f756af",
            hex"cefad4e508c098b9a7e1d8feb19955fb02ba9675585078710969d3440f5054e0",
            hex"f9dc3e7fe016e050eff260334f18a5d4fe391d82092319f5964f2e2eb7c1c3a5",
            hex"f8b13a49e282f609c317a833fb8d976d11517c571d1221a265d25af778ecf892",
            hex"3490c6ceeb450aecdc82e28293031d10c7d73bf85e57bf041a97360aa2c5d99c",
            hex"c1df82d9c4b87413eae2ef048f94b4d3554cea73d92b0f7af96e0271c691e2bb",
            hex"5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc",
            hex"da7bce9f4e8618b6bd2f4132ce798cdc7a60e7e1460a7299e3c6342a579626d2",
            hex"2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f",
            hex"e1d3b5c807b281e4683cc6d6315cf95b9ade8641defcb32372f1c126e398ef7a",
            hex"5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0",
            hex"b46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0",
            hex"c65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2",
            hex"f4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9",
            hex"5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377",
            hex"4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652",
            hex"cdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef",
            hex"0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d",
            hex"b8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0",
            hex"838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e",
            hex"662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e",
            hex"388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322",
            hex"93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735",
            hex"8448818bb4ae4562849e949e17ac16e0be16688e156b5cf15e098c627c0056a9"
        ];

        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        IBridge(Testnet.BRIDGE).claimMessage(
            LibClaimer.convertToProofArray(localProofHexStrings),
            LibClaimer.convertToProofArray(rollupProofHexStrings),
            LibClaimer.computeGlobalIndex(originNetwork, depositCount),
            bytes32(
                bytes(
                    hex"3a846cd5b7a4e2800e3c10eaeee37184a29d8d4924bfa325106dd46a900ced00"
                )
            ), // mainnetExitRoot
            bytes32(
                bytes(
                    hex"9e47cb9c6c92cda184d144a22b2b4efa11e127704cc866510554aa24df6efbdc"
                )
            ), // rollupExitRoot
            uint32(originNetwork),
            originAddr,
            uint32(destinationNetwork),
            destinationAddr,
            0, // amount
            bytes(
                hex"0000000000000000000000000000000000000000000000000000000000001c62000000000000000000000000d189584dc079ce08db854f17ab125ffda6128dfc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000088342beb50513c9994696c1dadeedad5e8b763df00000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000184da5b4ffd00000000000000000000000088342beb50513c9994696c1dadeedad5e8b763df000000000000000000000000082b1110e5a9068dbfc654c54a23c4c10f23e9b20000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000044095ea7b3000000000000000000000000082b1110e5a9068dbfc654c54a23c4c10f23e9b20000000000000000000000000000000000000000000001b1ae4d6e2ef5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024a0712d680000000000000000000000000000000000000000000001b1ae4d6e2ef50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
            ) // metadata
        );
        vm.stopBroadcast();
    }
}
