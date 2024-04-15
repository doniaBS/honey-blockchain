// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.5.0;

//import "./BeekeeperContract.sol";

contract HashStorage {
    address public owner;
    //BeekeeperContract public beekeeperContract;// Reference to the BeekeeperContract's address
    struct HashInfo { 
        bytes32 ipfsHash; 
        address beekeeperAddress;
    }
    mapping(uint256 => HashInfo) public hashes;

    // Event to emit the stored IPFS hash
    event IPFSHashStored(uint256 identifier, bytes32 ipfsHash, address beekeeperAddress);

    // Event to signal receiving the beekeeper address
    event BeekeeperAddressReceived(address beekeeperAddress);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    //constructor(address _beekeeperContractAddress)
    constructor() public{
        owner = msg.sender;
        //beekeeperContract = BeekeeperContract(_beekeeperContractAddress); // Initialize the BeekeeperContract instance
    }

    // Function to receive the beekeeper address from MetaMask
    function storeBeekeeperAddress(address beekeeperAddress) public {
        require(beekeeperAddress != address(0), "Beekeeper address cannot be empty");
        // Emit an event to signal receiving the beekeeper address
        emit BeekeeperAddressReceived(beekeeperAddress);
    }

     // Function to generate an identifier based on timestamp and transaction hash
    function generateIdentifier(bytes32 transactionHash) private view returns (uint256) {
        uint256 timestamp = block.timestamp; // Get current timestamp
        return uint256(keccak256(abi.encodePacked(timestamp, transactionHash))); // Combine timestamp and transaction hash
    }

    // Function to store an IPFS hash
    function storeIPFSHash(bytes32 ipfsHash) external {
        require(ipfsHash.length > 0, "IPFS hash cannot be empty");
        address beekeeperAddress = msg.sender; // Obtain beekeeper's Ethereum address
        bytes32 transactionHash = keccak256(abi.encodePacked(msg.sender, now));
        uint256 identifier = generateIdentifier(transactionHash); // Associate the Generated identifier with each hash
        hashes[identifier] = HashInfo(ipfsHash, beekeeperAddress); // Store the hash information along with the beekeeper's Ethereum address in the mapping
        // Emit the IPFS hash stored event
        emit IPFSHashStored(identifier, ipfsHash, beekeeperAddress);
    }
}