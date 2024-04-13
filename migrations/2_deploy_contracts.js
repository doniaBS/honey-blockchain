const BeekeeperContract = artifacts.require("BeekeeperContract");
const StoreHashContract = artifacts.require("HashStorage");

module.exports = function(deployer, network, accounts) {
  // Assuming Ganache provides 10 accounts
  const ganacheAddresses = accounts.slice(0, 10);
  // Deploy BeekeeperContract, then deploy HashStorage, passing in BeekeeperContract's newly deployed address
  deployer.deploy(BeekeeperContract, ganacheAddresses).then(function() {
    return deployer.deploy(StoreHashContract, BeekeeperContract.address);
  });
};