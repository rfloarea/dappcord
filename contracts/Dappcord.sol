// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Dappcord is ERC721 {

    // state variables
    uint public totalSupply;
    uint256 public totalChannels;
    address public owner;

    // struct is used to create an ariturary data structure with properties
    // it just defines how a channel works, it doesn't create one
    struct Channel {
        uint256 id;
        string name;
        uint256 cost;
    }

    // a mapping is a key : value pair
    // a mapping is defined by stating the data type of a key
    // attahced to a value
    // we then save that pair to an arbiturary variabel `channels`
    // and made it public so we can read it outside the smartcontract
    mapping(uint256 => Channel) public channels;
    /*
    this is a nested mapping
    it is a mapping that contains a mapping
    its 2 dementional
    how it works:
        in channel `uint265`, we check this person's address and return true/false if they are in/out
        then in the next channel, we check again for that address and return true/false
    it will default to false
    */
    mapping(uint256 => mapping(address => bool)) public hasJoined;

    modifier onlyOwner {
        // use require so only the owner/moderator can create a channel
        // the createChannel function stops at this line if require evaluates to false
        require( msg.sender == owner);  
        // this represents the function body on which this modifier is called
        _;  
    }
    
    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) 
    {
        owner = msg.sender;
    }

    // fyi, the cost is to join the channel, not create it
    // uint256 is any non-negative integer. It can also be zero
    // public is to this function can be called from outside this contract
    // onlyOwner runs a check to make sure it's the owner calling this function
    function createChannel(string memory _name, uint256 _cost) public onlyOwner {
        // create a new channel with id, name, and cost 
        // by using our mapping
        // incriment our state variable `totalChannels` so we don't override our channel every time we call this function
        totalChannels++;
        channels[totalChannels] = Channel(totalChannels, _name, _cost);
    }

    // payable means that they have to send currency for this transac tions
    function mint(uint256 _id) public payable {
        // our chanels start at 1
        require(_id != 0);
        // we can't join a channel that doesn't exist
        require(_id <= totalChannels);
        // can't join a channel twice
        require(hasJoined[_id][msg.sender] ==  false);
        // paying the correct amount
        require(msg.value >= channels[_id].cost);


        // join channel
        // set the mapping of hasJoined for this address to true
        hasJoined[_id][msg.sender] = true;


        // mint NFT
        // use openzepp's function to mint
        // msg.sender is the wallet the eth is going to
        totalSupply++;
        _safeMint(msg.sender, totalSupply);
    }


    // view means it's a read only function (it doesn't modify the state)
    // returns a channel from memory
    function getChannel(uint256 _id) public view returns (Channel memory) {
        return channels[ _id];
    }

    // now we create a function for the owner to be able to withdraw the crypto
    function withdraw() public onlyOwner {
        // owner.call just send a message to the owner
        // `this` is the SC we are coding inside of
        // .balance get the entire balance of the eth contract
        // the empty call at the end is just if we wanted to send anything else with the value (but we don't)
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success);
    }

}
