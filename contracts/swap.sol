// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ILBPair} from "./interfaces/ILBPair.sol";
import {ILBRouter} from "./interfaces/ILBRouter.sol";


contract Swap {

    ILBRouter public router = ILBRouter(0x18556DA13313f3532c54711497A8FedAC273220E);
    ILBPair public pairWavax = ILBPair(0xF4f265B46d069561b2CC62FA8e5eC61FBb3F051E);
    IERC20 public WAVAX = IERC20(0xd00ae08403B9bbb9124bB305C09058E32C39A48c);
    IERC20 public USDT = IERC20(0xAb231A5744C8E6c45481754928cCfFFFD4aa0732);
    
    
    function swapAVAXForUSDT(address to, uint256 _amountIn) external payable returns (uint256) {
        require(msg.value >= _amountIn, "Sent AVAX does not match amountIn");
        uint256 amountIn = _amountIn;
        require(amountIn <= type(uint128).max, "Amount too large");
        
        IERC20[] memory tokenPath = new IERC20[](2);
        tokenPath[0] = WAVAX;
        tokenPath[1] = USDT;
        
        uint256[] memory pairBinSteps = new uint256[](1);
        pairBinSteps[0] = 25;
        
        ILBRouter.Version[] memory versions = new ILBRouter.Version[](1);
        versions[0] = ILBRouter.Version.V2_2;
        
        ILBRouter.Path memory path; // instanciate and populate the path to perform the swap.
        path.pairBinSteps = pairBinSteps;
        path.versions = versions;
        path.tokenPath = tokenPath;
        
        (, uint128 amountOut, ) = router.getSwapOut(pairWavax, uint128(amountIn), false);
        
        uint256 amountOutWithSlippage = amountOut * 99 / 100;
        
        uint256 amountOutReal = router.swapExactNATIVEForTokens{value: amountIn}(
            amountOutWithSlippage,
            path,
            to,
            block.timestamp + 1
        );
        
        return amountOutReal;
    }
    
    receive() external payable {}
}