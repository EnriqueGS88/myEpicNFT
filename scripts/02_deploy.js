const main = async() => {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFTRandom64");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contracted deployed to:", nftContract.address);

    // Call the function at deploy time
    let txn = await nftContract.makeAnEpicNFT();
    // Wait for the txn to be mined
    await txn.wait();
    console.log(`NFT 1 minted now: ${await nftContract.tokenURI(0)}`);
    
    // Mint another NFT next
    txn = await nftContract.makeAnEpicNFT();
    await txn.wait();
    console.log(`NFT 2 minted now: ${await nftContract.tokenURI(1)}`);


};



const runMain = async() => {
    try{
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();

module.exports.tags = ['quasirandomsvg'];