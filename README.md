# Dappcord

## What is this?
This is a Discord clone with a blockchain twist. Users must mint NFTs in order to join channels. Pretty cute. This has been my first step into writing smart contracts and building dapps. I really like it!

## What did I learned?
1. Solidity. Not all of it, of course. But I enjoyed getting a feel for the language. It feels natural so far.
2. A taste of the dev environment for dapps. 
3. A taste of the complexity of larger apps. I'm new to this. This is the largest project I've coded. And yes, it's just a tutorial. But this experience of flexing all the way through has been hugely beneficial. Previous attempts at projects always felt so stunted. Seeing everything is really helpful!
4. Mostly, this has confirmed my curiosity for blockchain and crypto development.

## Technology Stack & Tools

- [Solidity](https://soliditylang.org/) (Writing smart contracts & Tests)
- [Hardhat](https://hardhat.org/) (Development framework)
    - [Mocha](https://mochajs.org/) (Test runner)
- [Ethers.js](https://docs.ethers.io/v5/) (Blockchain interaction)
- [React.js](https://reactjs.org/) (Frontend framework)
- [Express](https://expressjs.com/) (Node framework)
- [Socket.io](https://socket.io/) (Client & server communication)

## Before Setup
- Install [NodeJS](https://nodejs.org/en/)

## Setting Up
### 1. Clone/Download the Repository

### 2. Install Dependencies:
`$ npm install`

### 3. Run tests
`$ npx hardhat test`

### 4. Start Hardhat node
`$ npx hardhat node`

### 5. Run deployment script
In a separate terminal execute:
`$ npx hardhat run ./scripts/deploy.js --network localhost`

### 6. Start Socket.io server
`$ node server.js`

### 7. Start frontend
In a separate terminal execute:
`$ npm run start`