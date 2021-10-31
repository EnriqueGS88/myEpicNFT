// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

// Utilities functions
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "hardhat/console.sol";

// Import helper functions to encode in Base64
import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFTRandom64 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    // base SVG code that will be stored as a variable
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinyMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // Arrays of Words that will be combined separately
    string[] firstWords = ["Unbelievable", "Untameable", "Unbearable", "Domesticated", "Lubricated", "Guillable", "Hilarious", "Hideous", "Captivated", "Capsized", "Pompous", "Vulnerable", "Credulous", "Excited", "Submisive"];
    string[] secondWords = ["Sausage", "Bear", "Milkmaid", "Aubergine", "Nurse","Egg", "Plumber", "Secretary", "Firefighter", "Mosquito", "Coconut", "Mango", "Welder", "Carpenter", "Housemaid"];
    string[] thirdWords = ["Maker", "Taker", "Shaver", "Distributor", "Salesman", "Caretaker", "Avenger", "Freezer", "Protector", "Polisher", "Picker", "Depilator", "Cleaner", "Watcher", "Player"];

    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Kaboom64!");
    }

    // Functions that pick randomly a words
    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
        // seed a random generator
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        // Set bounds for the array by using a module
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

       function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

        function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        //Grab randomly a words from each array
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        // Combine all randomly picked words to use them later in the metadata json
        string memory combinedWord = string(abi.encodePacked(first, second, third));

        // concatenate all words together and close SVG tags </text> and </svg>
        string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));
        
        // Below is snippet specific for Base64 encoding
        // Next create the json metadata
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // Set the title as the NFT generator word
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // Now add the data image prefixe and append the SVG in base64
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Now add prefix data application to be read by browser
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        
        
        console.log("\n-----------------");
        console.log(finalTokenUri);
        console.log("-------------------\n");

        _safeMint(msg.sender, newItemId);

        // tokenURI to be set later on
        _setTokenURI(newItemId, "blah");

        _tokenIds.increment();
        console.log("an NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        }

}