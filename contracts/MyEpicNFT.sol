// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    // Methods called from the OpenZeppelin contracts
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Pass NFTs Token name and symbol
    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Woah!!");
    }

    // function for end users to create NFT
    function makeAnEpicNFT() public {
        // Get current tokenId, it always starts with 0
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the msg.sender
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data
        _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiVW50YW1lYWJsZVNhdXNhZ2VXcmVzdGxlciIsCiAgICAiZGVzY3JpcHRpb24iOiAiVGhlIGNoYW1waW9uIGV2ZXJ5IHNhdXNhZ2UgZGVzZXJ2ZXMiLAogICAgImltYWdlIjoiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0FnSUR4emRIbHNaVDR1WW1GelpTQjdJR1pwYkd3NklIZG9hWFJsT3lCbWIyNTBMV1poYldsc2VUb2djMlZ5YVdZN0lHWnZiblF0YzJsNlpUb2dNVFJ3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKaWJHRmpheUlnTHo0S0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krUlhCcFkweHZjbVJJWVcxaWRYSm5aWEk4TDNSbGVIUStDand2YzNablBnPT0iCn0=");
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        // Increment the counter for the next NFT
        _tokenIds.increment();
    }


}