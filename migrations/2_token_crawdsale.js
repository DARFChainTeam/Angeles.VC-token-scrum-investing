var AngelContract = artifacts.require("./AngelContract.sol");
var Token = artifacts.require("./ANGToken.sol");

module.exports = deployer => {
  var owner = web3.eth.accounts[0];

  return deployer.deploy(Token).then(() => {
    console.log("ANG token address:" + Token.address);
  return deployer.deploy(AngelContract,Token.address).then(() => {
    console.log("AngelContract address: "+ AngelContract.address );
  });
});
};
