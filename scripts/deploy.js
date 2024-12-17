const { ethers, upgrades } = require("hardhat");

async function main() {
  [owner] = await ethers.getSigners();

  // Deploy spotter Token (ERC20)
  const Token = await ethers.getContractFactory("SpotterToken");
  let spotterToken = await Token.deploy(
    "SpotterToken",
    "SPOT",
    "5",
    "5",
    owner.address,
    "0xd76DfEBE7272f569dD7D15167140E172Cf3c4f12",
    "0x63F5e5CbB3E414A23e64F79d3c6531b3Fee2B535"
  );
  console.log("spotter Token Contract...", spotterToken.target);

  // Deploy Presale SpoterUpgradablePreSale (ERC20)
  const SpoterUpgradablePreSale = await ethers.getContractFactory(
    "SpoterUpgradablePreSale"
  );
  console.log("Deploying PreSale Contract...");
  let spotterContract = await upgrades.deployProxy(
    SpoterUpgradablePreSale,
    [
      owner.address,
      "0x383263C943616BD79428c2cC1157620ba29f25bf",
      spotterToken.target,
    ],
    { initializer: "initialize" }
  );
  await spotterContract.waitForDeployment();
  console.log("Deploying presale Contract Contract...", spotterContract.target);

  // Deploy Presale SixenseUpgradablePreSale (ERC20)
  const SixenseUpgradablePreSale = await ethers.getContractFactory(
    "SixenseUpgradablePreSale"
  );
  console.log("Deploying PreSale Contract...");
  let sixenseContract = await upgrades.deployProxy(
    SixenseUpgradablePreSale,
    [
      owner.address,
      "0x383263C943616BD79428c2cC1157620ba29f25bf",
      "0x4bCEb277fF556010E5A116668bF52148864F5023",
    ],
    { initializer: "initialize" }
  );
  await sixenseContract.waitForDeployment();
  console.log("Deploying sixense Contract Contract...", sixenseContract.target);


  //////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////// Contract Verify ////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////

  // await verifyContract(spotterToken.target, []);
}

async function verifyContract(contractAddress, constructorArguments) {
  try {
    console.log(`Verifying contract at ${contractAddress}...`);
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: constructorArguments,
    });
  } catch (error) {
    console.error(`Verification failed for ${contractAddress}:`, error);
  }
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
