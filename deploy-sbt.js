const { ethers } = require("hardhat");

async function main() {
  const [issuer] = await ethers.getSigners();

  console.log("Deploying Soulbound Registry with account:", issuer.address);

  const SBT = await ethers.getContractFactory("SoulboundRegistry");
  const sbt = await SBT.deploy("Verified Developer", "VDEV");

  await sbt.waitForDeployment();

  const address = await sbt.getAddress();
  console.log("SBT Registry deployed to:", address);

  // Example: Issuing a token to a developer
  const devAddress = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";
  const tx = await sbt.issue(devAddress);
  await tx.wait();
  
  console.log(`Issued Soulbound ID to ${devAddress}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
