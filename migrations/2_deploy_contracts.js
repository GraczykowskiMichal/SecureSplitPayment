var SecureSplitPayment = artifacts.require("./SecureSplitPayment.sol");

module.exports = function(deployer) {
  deployer.deploy(SecureSplitPayment);
};
