const main = async() => {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFTRandom64");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contracted deployed to:", nftContract.address);

    // Call the function at deploy time

    for ( i=0; i<15; i++) {
    let txn = await nftContract.makeAnEpicNFT();
    // Wait for the txn to be mined
    await txn.wait();
    console.log(`NFT ${i+1} minted now: ${await nftContract.tokenURI(i)}`);
    }
    

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