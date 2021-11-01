// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.0;

// Utilities functions
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "hardhat/console.sol";

contract MyEpicNFTRandom is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    // base SVG code that will be stored as a variable
    string baseSvg1 = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinyMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style>< rect width='100%' height='100%' fill='";
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
        "Submisive"
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
        "Housemaid"
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
        "Player"
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

    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Kaboom!");
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
        uint256 newItemId = _tokenIds.current();

        //Grab randomly a words from each array
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory backgroundColor = pickRandomBackground(newItemId);

        // concatenate all words together and close SVG tags </text> and </svg>
        string memory finalSvg = string(abi.encodePacked(baseSvg1, backgroundColor, baseSvg2, first, second, third, "</text></svg>"));
        console.log("\n-----------------");
        console.log(finalSvg);
        console.log("-------------------\n");

        _safeMint(msg.sender, newItemId);

        // tokenURI to be set later on
        _setTokenURI(newItemId, "blah");

        _tokenIds.increment();
        console.log("an NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        emit NewEpicNFTMinted(msg.sender, newItemId);
        }

}