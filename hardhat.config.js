require("@nomiclabs/hardhat-waffle");
require('hardhat-deploy');
require('@nomiclabs/hardhat-etherscan');



// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/0KfNnMyWYPAMcik0S45TwbkAHqXDUHdc',
      accounts: ['b6b82362578654711ecccb952e60b830caffd97cd6c0ca98954cfa44209f70d6']
    },
  },
  etherscan:{
    apiKey:"WFNEX4S15R9XXQBJ5QVCZK1F2NG8PGMIIK"
  }
};
