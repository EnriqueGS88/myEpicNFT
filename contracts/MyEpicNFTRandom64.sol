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

    // Variables for the ERC721 contract
    uint256 public tokenCounter;
    uint256 public tokenSupply;

    // base SVG code that will be stored as a variable
    string baseSvg1 = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinyMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
    string baseSvg2 = "' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

// Arrays of Words that will be combined separately
    string[] firstWords = [
        "Unbelievable",
        "Untameable",
        "Unbearable",
        "Domesticated",
        "Lubricated",
        "Guillable",
        "Hilarious",
        "Hideous",
        "Captivated",
        "Capsized",
        "Pompous",
        "Vulnerable",
        "Credulous",
        "Excited",
        "Submisive",
        "Neurotic",
        "Hysterical",
        "Pompous",
        "Farcical",
        "Emblematic"
        ];
    string[] secondWords = [
        "Sausage",
        "Bear",
        "Milkmaid",
        "Aubergine",
        "Nurse",
        "Egg",
        "Plumber",
        "Secretary",
        "Firefighter",
        "Mosquito",
        "Coconut",
        "Mango",
        "Welder",
        "Carpenter",
        "Housemaid",
        "Horse",
        "Schoolgirl",
        "Skirt",
        "Lumberjack",
        "Sweage"
        ];
    string[] thirdWords = [
        "Maker",
        "Taker",
        "Shaver",
        "Distribuitor",
        "Salesman",
        "Caretaker",
        "Avenger",
        "Freezer",
        "Protector",
        "Polisher",
        "Picker",
        "Depilator",
        "Cleaner",
        "Watcher",
        "Player",
        "Plower",
        "Licker",
        "Spanker",
        "Trainer",
        "Analyst"
        ];
    string[] background = [
        "aqua",
        "bisque",
        "black",
        "blueviolet",
        "burlywood",
        "coral",
        "cornflowerblue",
        "dimgray",
        "fuchsia",
        "hotpink",
        "lightblue",
        "lightcoral",
        "lightsteelblue",
        "orchid",
        "palevioletred"
    ];    

    event NewEpicNFTMinted(address sender, uint256 tokenId);
    event CreatedEpicSVG(uint256 indexed tokenId, string tokenURI);

    constructor() ERC721 ("Epitaphs Generator", "EPITS") {
        tokenCounter = 0;
        tokenSupply = 999;
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

    function pickRandomBackground(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("BACKGROUND", Strings.toString(tokenId))));
        rand = rand % background.length;
        return background[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        require( tokenCounter < tokenSupply, "All tokens have already been minted" );
        uint256 newItemId = _tokenIds.current();
        tokenCounter = tokenCounter + 1;

        //Grab randomly a words from each array
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory backgroundColor = pickRandomBackground(newItemId);


        // Combine all randomly picked words to use them later in the metadata json
        string memory combinedWord = string(abi.encodePacked(first, second, third));

        // concatenate all words together and close SVG tags </text> and </svg>
        string memory finalSvg = string(abi.encodePacked(baseSvg1, backgroundColor, baseSvg2, combinedWord, "</text></svg>"));
        
        // Below is snippet specific for Base64 encoding
        // Next create the json metadata
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        // Set the title as the NFT generator word
                        '{"name": "',combinedWord,'",',
                        '"description": "A colourful collection of squares.",',
                        '"attributes": [',
                        '{"trait_type":"Clan","value":"',backgroundColor,'"},',
                        '{"trait_type":"Work","value":"',third,'"},',
                        '{"trait_type":"Virtue","value":"',first,'"}',
                        '],',
                        '"image": "data:image/svg+xml;base64,',
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
        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        console.log("an NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        
        emit NewEpicNFTMinted(msg.sender, newItemId);
        emit CreatedEpicSVG(newItemId, finalTokenUri);

        }

}