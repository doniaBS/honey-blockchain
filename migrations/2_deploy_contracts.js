const StoreHashContract = artifacts.require("HashStorage");

module.exports = function(deployer) {
  deployer.deploy(StoreHashContract);
};
