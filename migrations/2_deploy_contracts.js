const StoreHash = artifacts.require("StoreHashContract");

module.exports = function(deployer) {
  deployer.deploy(StoreHash);
};
