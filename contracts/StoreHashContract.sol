// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.5.0;

contract HashStorage {
    address public owner;
    mapping(uint256 => bytes32) private hashes;
    uint256 private nextHashId = 1;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() public{
        owner = msg.sender;
    }

     // Function to generate an identifier based on timestamp and transaction hash
    function generateIdentifier(bytes32 transactionHash) private view returns (uint256) {
        uint256 timestamp = block.timestamp; // Get current timestamp
        return uint256(keccak256(abi.encodePacked(timestamp, transactionHash))); // Combine timestamp and transaction hash
    }

    // Function to store an IPFS hash
    function storeIPFSHash(bytes32 ipfsHash) external {
        require(ipfsHash.length > 0, "IPFS hash cannot be empty");
        hashes[nextHashId] = ipfsHash;
        nextHashId++;
    }

    // Function to retrieve all stored IPFS hashes
    function retrieveAllHashes() external view returns (bytes32[] memory) {
        bytes32[] memory storedHashes = new bytes32[](nextHashId - 1);
        for (uint256 i = 1; i < nextHashId; i++) {
            storedHashes[i - 1] = hashes[i];
        }
        return storedHashes;
    }
}