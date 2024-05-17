## LZ Helper Scripts 🛠️🚀

## Quickstart

```
git clone https://github.com/Kuzirashi/layerzero-starter-kit.git
cd layerzero-starter-kit
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

Preparation:
```
cp .env.example .env
```

Fill `TEST_DEPLOYER_KEY` and `TEST_OWNER_ADDRESS` before running deployment script.

Dry run:

```shell
forge script DeployCounter -s "deployCounterTestnet(uint256, uint256)" 1 1 --force --multi
```

To send transactions and actually deploy just add `--broadcast` flag to the command above.

*Note: `1 1` parameters are respectively: `uint256 _counterSalt, uint256 _counterProxySalt`. It affects generated addresses. If you have problem with deployment script failing try changing `1 1` to some random numbers instead. You can't deploy with the same salt twice - it fails with message: `script failed: <no data>`.*

*Note: Don't use automatic `--verify` flag because it doesn't seem to work.*

### Upgrade

Please set `TEST_COUNTER_PROXY_ADDRESS` in `.env` to make sure correct proxy is updated.

```
forge script UpgradeCounter -s "upgradeTestnet()" --force --multi
```

Add `--broadcast` when you're ready to send actual transactions ([example tx](https://sepolia.etherscan.io/tx/0xea00205afe187a984676c68e50d59b5493be72cd1204a7e424ffccdc7c80e1fa)).

### Verify

[Read VERIFICATION.md.](./VERIFICATION.md)

### Testing Sending Tokens between Chains

To test the sending of tokens between chains, you can use the `sendTokens` script. This script will send tokens from the sender chain to the receiver chain. The script will also send a message to the receiver chain with the transaction hash of the token transfer. The receiver chain will then verify the transaction hash and mint the tokens to the receiver.

For Testnet
```shell
forge script MintAndTestSend -s "sendTokens(address,address, uint256, address)" TOKEN_ADDRESS TOKEN_ADDRESS 1000000000000000000 ADDRESS_TO_SEND_TO --force --multi
```

For Mainnet

```shell
forge script MintAndTestSend -s "sendTokensMainnet(address,uint256, address, uint256, uint256)" TOKEN_ADDRESS 1000000000000000000 ADDRESS_TO_SEND_TO 0 1 --force --multi
```

### Demo deployment

[Read EXISTING_DEPLOYMENT.md.](./EXISTING_DEPLOYMENT.md)

### Compatibility

Tested with:
```
forge 0.2.0 (71d8ea5 2024-01-09T14:41:14.837767655Z)
```

## Inspiration 💡

This repository is, to a significant extent, a compilation of other people's work. I just put these separate pieces together to achieve best developer experience possible.

LayerZero libraries and examples are based on: https://github.com/LayerZero-Labs/LayerZero-v2.

Multichain script deployment setup is heavily based on: https://github.com/timurguvenkaya/foundry-multichain by @timurguvenkaya.

LayerZero OApp Upgradeability is taken from: https://github.com/Zodomo/LayerZero-v2/tree/main by @Zodomo.

*Note: Initially I have used my own implementation but I think @Zodomo version is slightly better structured. I've noticed that implementation after I created this repository.*

## License

[MIT](./LICENSE.md)
