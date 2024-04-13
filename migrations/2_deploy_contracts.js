const StoreHashContract = artifacts.require("HashStorage");
const BeekeeperContract = artifacts.require("./BeekeeperContract.sol");

module.exports = function(deployer) {
  deployer.deploy(BeekeeperContract).then(() => {
    return deployer.deploy(StoreHashContract, BeekeeperContract.address);
  });
};

