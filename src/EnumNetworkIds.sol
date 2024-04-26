// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

enum NetworkId {
    // Mainnet Ids are mapped the same to Testnet Ids
    Ethereum, // == Sepolia
    PolygonZkEVM, // == Cardona
    Astar, // == zKyoto
    XLayer // == XLayer Testnet
}
