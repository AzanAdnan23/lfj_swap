# Swap Contract README

## Overview
This smart contract swaps AVAX for USDT on the Avalanche Fuji testnet using WAVAX as an intermediary.

## How It Works
- Accepts AVAX from the sender.
- Wraps AVAX into WAVAX.
- Swaps WAVAX for USDT using the Liquidity Book Router.
- Sends USDT to the specified recipient.

## Key Functions
- `swapAVAXForUSDT(address to, uint256 _amountIn)`: Swaps `_amountIn` AVAX for USDT and sends it to `to`.

## Requirements
- The contract must be funded with AVAX.
- The swap uses Trader Joe's Liquidity Book V2.2.

## Addresses (Fuji Testnet)
- **Router:** `0x18556DA13313f3532c54711497A8FedAC273220E`
- **WAVAX:** `0xd00ae08403B9bbb9124bB305C09058E32C39A48c`
- **USDT:** `0xAb231A5744C8E6c45481754928cCfFFFD4aa0732`
- **WAVAX/USDT Pair:** `0xF4f265B46d069561b2CC62FA8e5eC61FBb3F051E`

## Notes
- A 1% slippage tolerance is applied.
- The contract can receive AVAX (`receive()` function).