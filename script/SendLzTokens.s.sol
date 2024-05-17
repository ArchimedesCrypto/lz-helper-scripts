pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {BaseDeployer} from "./BaseDeployer.s.sol";
import {UUPSProxy} from "../src/UUPSProxy.sol";
import {MessagingFee, MessagingReceipt} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oft/OFTCore.sol";
import {IOFT, SendParam, OFTReceipt} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oft/interfaces/IOFT.sol";
import {OptionsBuilder} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/libs/OptionsBuilder.sol";

import { OFT } from "../src/OFT.sol";

contract SendLzTokens is Script, BaseDeployer {

    using OptionsBuilder for bytes;

    uint256 tokenAmount = vm.envUint("TOKEN_AMOUNT_TO_SEND");

    struct LayerZeroChainDeployment {
        Chains chain;
        address endpoint;
        uint32 endpointId;
    }

    LayerZeroChainDeployment[] private targetChainsTestnet;

    LayerZeroChainDeployment[] private targetChainsMainnet;

    function setUp() public {
        // Endpoint configuration from: https://docs.layerzero.network/v2/developers/evm/technical-reference/endpoints
        targetChainsTestnet.push(LayerZeroChainDeployment(Chains.Sepolia, 0x6EDCE65403992e310A62460808c4b910D972f10f, 40161));
        targetChainsTestnet.push(LayerZeroChainDeployment(Chains.ArbitrumSepolia, 0x6EDCE65403992e310A62460808c4b910D972f10f, 40231));
        targetChainsTestnet.push(LayerZeroChainDeployment(Chains.BaseSepolia, 0x6EDCE65403992e310A62460808c4b910D972f10f, 40245));

        targetChainsMainnet.push(LayerZeroChainDeployment(Chains.Ethereum, 0x1a44076050125825900e736c501f859c50fE728c,30101));
        targetChainsMainnet.push(LayerZeroChainDeployment(Chains.Arbitrum, 0x1a44076050125825900e736c501f859c50fE728c, 30110));
        targetChainsMainnet.push(LayerZeroChainDeployment(Chains.Base, 0x1a44076050125825900e736c501f859c50fE728c, 30184));


    }

    function run() public {

    }

    function sendTokens(address tokenChain1, address tokenChain2, uint256 amountToSend, address owner) public setEnvMintAndSend(Cycle.Test){

        uint256[] memory forkIds = new uint256[](targetChainsTestnet.length);

        address[] memory deployedContracts = new address[](targetChainsTestnet.length);
        deployedContracts[1] = tokenChain1;
        deployedContracts[0] = tokenChain2;

        console2.log("Sending from chain:", "\n");

        string memory chainRPC = forks[targetChainsTestnet[1].chain];

        uint256 forkId = vm.createSelectFork(chainRPC);
        //forkIds[0] = forkId;
        console2.log("Fork Id: ", forkId, "\n");

        _sendTokens(tokenChain1, targetChainsTestnet[0].endpointId, amountToSend, owner);

    }

    function sendTokensTestnet(address tokenAddress, uint256 amountToSend, address owner, uint256 sourceIndex, uint256 destIndex) public setEnvMintAndSend(Cycle.Test){

        console2.log("Sending from chain:", "\n");

        string memory chainRPC = forks[targetChainsTestnet[sourceIndex].chain];
        console2.log("Chain RPC: ", chainRPC);

        uint256 forkId = vm.createSelectFork(chainRPC);
        //forkIds[0] = forkId;
        console2.log("Fork Id: ", forkId, "\n");

        _sendTokens(tokenAddress, targetChainsTestnet[destIndex].endpointId, amountToSend, owner);

    }

    function sendTokensMainnet(address tokenAddress, uint256 amountToSend, address owner, uint256 sourceIndex, uint256 destIndex) public setEnvMintAndSend(Cycle.Prod){

        console2.log("Sending from chain:", "\n");

        string memory chainRPC = forks[targetChainsMainnet[sourceIndex].chain];

        uint256 forkId = vm.createSelectFork(chainRPC);
        //forkIds[0] = forkId;
        console2.log("Fork Id: ", forkId, "\n");

        _sendTokens(tokenAddress, targetChainsMainnet[destIndex].endpointId, amountToSend, owner);

    }

    function _sendTokens(address tokenAddress, uint32 endpointIdDest, uint256 amountToSend, address owner)
    private
    broadcast(deployerPrivateKey)
    {

        SendParam memory sendParam = SendParam(endpointIdDest, addressToBytes32(owner), amountToSend, amountToSend);
        bytes memory options = OptionsBuilder.newOptions().addExecutorLzReceiveOption(100000, 0);
        MessagingFee memory fee = OFT(tokenAddress).quoteSend(sendParam, options, false, "", "");

        require(OFT(tokenAddress).balanceOf(owner) >= tokenAmount,"Balance of sender is not correct, please mint tokens");
        //assertEq(ambrosiaChain2.balanceOf(userB), 0);
        // Assume 10 gwei gas price
        //fee.nativeFee = 2_000_000 * 10e9;
        OFT(tokenAddress).send{value: fee.nativeFee}(sendParam, options, fee, payable(owner), "", "");


    }
}