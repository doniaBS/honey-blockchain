var BeekeeperContract = artifacts.require("./BeekeeperContract.sol");

module.exports = function(deployer) {
  deployer.deploy(BeekeeperContract);
};