// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.5.0;

contract BeekeeperContract {
   // structure of the beekeepers
   struct Beekeeper {
    uint beekeeperId;
    uint[] hiveIds;
    address beekeeperAddress;
   }
   //structure of the hives
   struct Hive {
    uint hiveId;
    uint beekeeperId; 
    uint sensorTemperatureValue;
    uint sensorHumidityValue;
    uint sensorCO2Value;
    uint sensorWeightValue;
    bool hasPests;
    bool hasDiseases;
    bool isBeesStateOkay;
    bool isOrganicHoney;
    bool isTemperatureOkay;
    bool isHumidityOkay;
    bool isCo2Okay;
    bool isWeightOkay;
   }
    // mapping both beekeepers and hives
    mapping(uint => Beekeeper) beekeepers;
    mapping(uint => Hive) hives;
    mapping(uint256 => address) private beekeeperAddresses;

    //Event to emit the association beekeeperId and Beekeeper address
     event beekeeperIdBeekeeperAddress(uint256 beekeeperId, address beekeeperAddress);
     //event to emit the hiveIds when a new hive is registered and link them to a beekeeper
     event HiveRegistered(uint hiveId, uint beekeeperId);

    constructor(address[] memory _ganacheAddresses) public {
        require(_ganacheAddresses.length >= 10, "Insufficient addresses provided");

        // Assign each Beekeeper ID to one of the Ganache addresses
        for (uint256 i = 0; i < 10; i++) {
            beekeeperAddresses[i] = _ganacheAddresses[i];
        }
    }

    // Function to register a beekeeper with a specified Ethereum address
    function registerBeekeeper(uint256 beekeeperId) external {
        require(beekeeperId < 10, "Beekeeper ID out of range");
        beekeepers[beekeeperId].beekeeperId = beekeeperId;
    }

    // Function to retrieve the Ethereum address of a beekeeper based on the beekeeperId
    function getBeekeeperAddress(uint256 beekeeperId) external returns (address) {
        require(beekeeperId < 10, "Beekeeper ID out of range");
        address beekeeperAddress = beekeeperAddresses[beekeeperId];
        emit beekeeperIdBeekeeperAddress(beekeeperId, beekeeperAddress);
        return beekeeperAddress;
    }
    // Function to register a hive and link it to a beekeeperId 
    function registerHive(uint256 hiveId, uint256 beekeeperId) external {
        require(beekeepers[beekeeperId].beekeeperId != 0, "Beekeeper does not exist");
        Hive storage hive = hives[hiveId];
        hive.hiveId = hiveId;
        hive.beekeeperId = beekeeperId;
        beekeepers[beekeeperId].hiveIds.push(hiveId);
        emit HiveRegistered(hiveId, beekeeperId);
    }
    // Function to process metadata, associate them to the declared data of hive struct and update hive state
    function processMetadata(uint256 hiveId,uint256 temperature,uint256 humidity,uint256 co2,uint256 weight,bool hasPests,bool hasDiseases) external 
    returns (bool isBeesStateOkay, bool isOrganicHoney, bool isTemperatureOkay, bool isHumidityOkay, bool isCo2Okay, bool isWeightOkay) {
        require(hives[hiveId].hiveId != 0, "Hive does not exist");
        Hive storage hive = hives[hiveId];
        // assing the received metadata to its equivalent in the hive struct
        hive.sensorTemperatureValue = temperature;
        hive.sensorHumidityValue = humidity;
        hive.sensorCO2Value = co2;
        hive.sensorWeightValue = weight;
        hive.hasPests = hasPests;
        hive.hasDiseases = hasDiseases;
        // Update hive state based on sensor values and other conditions using if statements
        if (hasDiseases) { hive.isBeesStateOkay = false;} 
        else {hive.isBeesStateOkay = true;}

        if (hasPests) { hive.isOrganicHoney = false;} 
        else {hive.isOrganicHoney = true;}

        if (temperature >= 30 && temperature <= 35) { hive.isTemperatureOkay = true;} 
        else { hive.isTemperatureOkay = false;}
        
        if (humidity >= 90 && humidity <= 95) { hive.isHumidityOkay = true;} 
        else { hive.isHumidityOkay = false;}

        if (co2 >= 1000 && co2 <= 4000) { hive.isCo2Okay = true;} 
        else { hive.isCo2Okay = false;}

        if (weight >= 30 && weight <= 80) { hive.isWeightOkay = true;} 
        else { hive.isWeightOkay = false;}

        // Return the updated hive state values
    return ( hive.isBeesStateOkay, hive.isOrganicHoney, hive.isTemperatureOkay, hive.isHumidityOkay, hive.isCo2Okay, hive.isWeightOkay);
    }
}



