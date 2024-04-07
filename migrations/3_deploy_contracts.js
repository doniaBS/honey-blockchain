var BeekeeperContract = artifacts.require("./BeekeeperContract.sol");

module.exports = function(deployer, network, accounts) {
  // Assuming Ganache provides 10 accounts
  const ganacheAddresses = accounts.slice(0, 10);

  deployer.deploy(BeekeeperContract, ganacheAddresses);
};