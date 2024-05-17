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

For Testnet
```shell
forge script SendLzTokens -s "sendTokensTestnet(address,uint256, address, uint256, uint256)" 0xd4080966b8656b34a86e6b9089d34edf1419826f 1000000000000000000 YOUR_KEY_ADDRESS 1 0 --force --multi --legacy --broadcast
```

For Mainnet

```shell
forge script SendLzTokens -s "sendTokensMainnet(address,uint256, address, uint256, uint256)" 0xd4080966b8656b34a86e6b9089d34edf1419826f 1000000000000000000 0x50875e20f88c2fba27d0c4ee2649d520ea7b2952 1 0 --force --multi --legacy --broadcast
```


### Compatibility

Tested with:
```
forge 0.2.0 (71d8ea5 2024-01-09T14:41:14.837767655Z)
```

[MIT](./LICENSE.md)
