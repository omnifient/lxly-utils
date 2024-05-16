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
// export RPC=https://1rpc.io/sepolia
// forge script script/ClaimAsset.s.sol:ClaimAsset --legacy --rpc-url ${RPC} -vvvv
// forge script script/ClaimAsset.s.sol:ClaimAsset --legacy --rpc-url ${RPC} -vvvv --broadcast
contract ClaimAsset is Script {
    function run() public {
        NetworkId originNetwork = NetworkId.Astar;
        NetworkId destinationNetwork = NetworkId.Ethereum;
        address originAddr = 0xe6e6809bBFA49cEE58988e532d71bddf83aD2A38;
        address destinationAddr = 0x5f569866798C56c7B3AF875976fB6fab84Fc70Bd;
        uint256 depositCount = 4294967779;
        string[32] memory localProofHexStrings = [
            hex"d4869454aeea308fb7ade8e014188a03c6907330cdd775ed2f6d2b4b92db1a79",
            hex"30aab3c8ddfa317617c8eb4a6ba68d6eeeedd1750b2eba342c742dd8bba25d81",
            hex"b4c11951957c6f8f642c4af61cd6b24640fec6dc7fc607ee8206a99e92410d30",
            hex"21ddb9a356815c3fac1026b6dec5df3124afbadb485c9ba5a3e3398a04b7ba85",
            hex"e58769b32a1beaf1ea27375a44095a0d1fb664ce2dd358e7fcbfb78c26a19344",
            hex"c8e14927fd8994a8bc66772b68deee00bf8638465b29f1dda09cba8519f32e19",
            hex"552af830901d3f5405a5d862c6f117cd5891a4c8315ef123657a098ce2ef35b0",
            hex"ae749a315c036690c59f85fab381789f6125cbbe428d6a7eb6685178a49a23c8",
            hex"330954095e884956617c6a5cbaceae4e1fa3da97841f66e4ef66478d1fd07f5c",
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
        string[32] memory rollupProofHexStrings = [
            hex"be8d4fb441091b0efe541e5cc738492cdc7238445f063e9d8600b1ba070e3cd3",
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
        IBridge(Testnet.BRIDGE).claimAsset(
            LibClaimer.convertToProofArray(localProofHexStrings),
            LibClaimer.convertToProofArray(rollupProofHexStrings),
            LibClaimer.computeGlobalIndex(originNetwork, depositCount),
            bytes32(
                bytes(
                    hex"8eb998bd111c0b3c39bd1931b3b136cd50d16695619b48909d5540d46439ac79"
                )
            ), // mainnetExitRoot
            bytes32(
                bytes(
                    hex"b08b76ab4589ecb409581fd8d991a2efe606806627e4df9e49572174401cffaf"
                )
            ), // rollupExitRoot
            uint32(originNetwork),
            originAddr,
            uint32(destinationNetwork),
            destinationAddr,
            8000000000000000000000, // amount
            bytes(
                hex"000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000120000000000000000000000000000000000000000000000000000000000000005446f6c6c610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005444f4c4c41000000000000000000000000000000000000000000000000000000"
            ) // metadata
        );
        vm.stopBroadcast();
    }
}
