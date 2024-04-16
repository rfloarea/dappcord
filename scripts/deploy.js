const hre = require("hardhat")

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

async function main() {
  // deployment code goes in here

  // Setup accounts and variables
  const [deployer] = await ethers.getSigners();
  const NAME = "dappcord";
  const SYMBOL = "DC";

  // Deploy contract
  const Dappcord = await ethers.getContractFactory("Dappcord");
  const dappcord = await Dappcord.deploy(NAME, SYMBOL);
  await dappcord.deployed();

  console.log(`Deployed Dappcord Contract at: ${dappcord.address}\n`)

  // Create 3 channels
  const CHANNEL_NAMES = ["general", "intro", "jobs"];
  const COSTS = [tokens(1), tokens(0), tokens(0.25)];
  for (let i = 0; i < 3; i++) {
    const transaction = await dappcord.connect(deployer).createChannel(CHANNEL_NAMES[i], COSTS[i]);
    await transaction.wait();
    console.log(`Channel channel: ${CHANNEL_NAMES[i]}`);
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});