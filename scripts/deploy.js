const main = async() => {
    const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contracted deployed to:", nftContract.address);

    // Call the function at deploy time
    let txn = await nftContract.makeAnEpicNFT();
    // Wait for the txn to be mined
    await txn.wait();
    console.log("NFT 1 minted now");
    
    // Mint another NFT next
    txn = await nftContract.makeAnEpicNFT();
    await txn.wait();
    console.log("NFT 2 minted now");


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

/* Rinkeby Faucets

You have a few faucets to choose from:

| MyCrypto | https://app.mycrypto.com/faucet

| Buildspace | https://buildspace-faucet.vercel.app/

| Ethily | https://ethily.io/rinkeby-faucet/

| Official Rinkeby | https://faucet.rinkeby.io/

*/