## LZ Helper Scripts 🛠️🚀

This is a collection of LayerZero Helper scripts that I write and find useful over time. 
Currently it has the following features.

1. Sending Lz Tokens 

## Quickstart

```
forge install
```

*Note: If you don't have Foundry installed yet please follow [installation guide](https://book.getfoundry.sh/getting-started/installation).*

## Usage

### Build

```shell
forge build
```

### Test

```shell
forge test
```

*Note: if you want to execute single test file you can add a flag, eg.: `--match-path ./test/CounterUpgradeability.t.sol`.*

### Deploy

Preparation: Copy the .env file first
```
cp .env.example .env
```

Fill `TEST_DEPLOYER_KEY` and `TEST_OWNER_ADDRESS` before running token sending script.
And fill the RPC values for the desired chains you wish to use. Fill the mainnet key/address for mainnet txfrs.




### Testing Sending Tokens between Chains

To test the sending of tokens between chains, you can use the `sendTokens` script. This script will send tokens from the sender chain to the receiver chain. The script will also send a message to the receiver chain with the transaction hash of the token transfer. The receiver chain will then verify the transaction hash and mint the tokens to the receiver.

Endpoint Indexes are 
```
0 - Eth
1 - Arbitrum
2 - Base
```

The example below sends 1 token from Arbitrum to ETH

WARNING: THIS SCRIPT ASSUMES YOUR TOKEN ADDRESSES ARE THE SAME ON ALL CHAINS

For Testnet
```shell
forge script SendLzTokens -s "sendTokensTestnet(address,uint256, address, uint256, uint256)" YOUR_TOKEN_ADDRESS 1000000000000000000 YOUR_KEY_ADDRESS 1 0 --force --multi --legacy --broadcast
```

For Mainnet

```shell
forge script SendLzTokens -s "sendTokensMainnet(address,uint256, address, uint256, uint256)" YOUR_TOKEN_ADDRESS 1000000000000000000 YOUR_KEY_ADDRESS 1 0 --force --multi --legacy --broadcast
```


### Compatibility

Tested with:
```
forge 0.2.0 (71d8ea5 2024-01-09T14:41:14.837767655Z)
```

[MIT](./LICENSE.md)
