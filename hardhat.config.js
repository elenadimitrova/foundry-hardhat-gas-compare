require("@nomicfoundation/hardhat-toolbox");
require("hardhat-gas-reporter");

module.exports = {
  solidity: {
    version: "0.8.15",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  gasReporter: {
    currency: 'USD',
    gasPrice: 21
  }
};
