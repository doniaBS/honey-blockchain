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
    uint gpsLocation;
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
        beekeepers[beekeeperId].beekeeperAddress = beekeeperAddresses[beekeeperId];
    }

    // Function to retrieve the Ethereum address of a beekeeper based on the beekeeperId
    function getBeekeeperAddress(uint256 beekeeperId) external returns (address) {
        require(beekeeperId < 10, "Beekeeper ID out of range");
        address beekeeperAddress = beekeeperAddresses[beekeeperId];
        emit beekeeperIdBeekeeperAddress(beekeeperId, beekeeperAddress);
        return beekeeperAddress;
    }

    // fucntion to check the bees state normal or not according to the udage of pests or having diseases
   function checkBeesState(uint hiveId) public returns (bool isOrganicHoney) {
    //check the existence of the hive id 
    require(hives[hiveId].hiveId != 0, "Hive does not exist");
    // update of the value of isBeesStateOkay according to the value of hasPestsOrDiseases
    if (!hives[hiveId].hasPests) {
        hives[hiveId].isOrganicHoney = true;
      } else {
        hives[hiveId].isOrganicHoney = false;
      }
    // after the traitment return the value of the isBeesState okay
    return isOrganicHoney;
   }
    //check the value of the temperature sensor in acceptable range or not
   function checkTemperatureSensorsValues(uint hiveId) public returns (bool isTemperatureOkay) {
    //declare variables
    uint minTemperature = 20;
    uint maxTemperature = 30;
    //check the existence of the hive id 
    require(hives[hiveId].hiveId != 0, "Hive does not exist");
    // check the range of temperature coming for sensors 
    bool temperatureSensorState = (hives[hiveId].sensorTemperatureValue >= minTemperature) && (hives[hiveId].sensorTemperatureValue <= maxTemperature);
    //check if the value of the humidity sensor is okay or not
    if (temperatureSensorState) {
        hives[hiveId].isTemperatureOkay = true;
      } else {
        hives[hiveId].isTemperatureOkay = false;
      }
    // after the traitment return the state of the temperature
    return isTemperatureOkay;
   }
   //check the value of the humidty sensor in acceptable range or not
   function checkHumiditySensorsValues(uint hiveId) public returns (bool isHumidityOkay) {
    //declare variables
    uint minHumidity = 40;
    uint maxHumidity = 50;
    //check the existence of the hive id 
    require(hives[hiveId].hiveId != 0, "Hive does not exist");
    // check the range of humidity coming for sensors 
    bool humiditySensorState = (hives[hiveId].sensorHumidityValue >= minHumidity) && (hives[hiveId].sensorHumidityValue <= maxHumidity);
    //check if the value of the humidity sensor is okay or not
    if (humiditySensorState) {
        hives[hiveId].isHumidityOkay = true;
      } else {
        hives[hiveId].isHumidityOkay = false;
      }
    // after the traitment return the state of the humidity
    return isHumidityOkay;
   }
   //check the value of the co2  sensor in acceptable range or not
   function checkCo2SensorsValues(uint hiveId) public returns (bool isCo2Okay) {
    //declare variables
    uint minCo2 = 60;
    uint maxCo2 = 70;
    //check the existence of the hive id 
    require(hives[hiveId].hiveId != 0, "Hive does not exist");
    // check the range of co2 coming for sensors 
    bool co2SensorState = (hives[hiveId].sensorCO2Value >= minCo2) && (hives[hiveId].sensorCO2Value <= maxCo2);
    //check if the value of the co2 sensor is okay or not
    if (co2SensorState) {
        hives[hiveId].isCo2Okay = true;
      } else {
        hives[hiveId].isCo2Okay = false;
      }
    // after the traitment return the state of the co2
    return isCo2Okay;
   }
   //check the value of the weight sensor in acceptable range or not
   function checkWeightSensorsValues(uint hiveId) public returns (bool isWeightOkay) {
    //declare variables
    uint minWeight = 80;
    uint maxWeight = 90;
    //check the existence of the hive id 
    require(hives[hiveId].hiveId != 0, "Hive does not exist");
    // check the range of co2 coming for sensors 
    bool weightSensorState = (hives[hiveId].sensorWeightValue >= minWeight) && (hives[hiveId].sensorWeightValue <= maxWeight);
    //check if the value of the co2 sensor is okay or not
    if (weightSensorState) {
        hives[hiveId].isWeightOkay = true;
      } else {
        hives[hiveId].isWeightOkay = false;
      }
    // after the traitment return the state of the weight
    return isWeightOkay;
   }
   // function to check the quality of honey organic or not according to the return of the previous function and the sensors informations
   function checkHoneyQuality(uint hiveId) public returns (bool isBeesStateOkay) {
     // have the value of the return of the function checkBeesState to use its return value
     bool beesState = checkBeesState(hiveId);
     bool temperatureState = checkTemperatureSensorsValues(hiveId);
     bool humidityState = checkHumiditySensorsValues(hiveId);
     bool co2State = checkCo2SensorsValues(hiveId);
     bool weightState = checkWeightSensorsValues(hiveId);
     bool has_diseases = hives[hiveId].hasDiseases;
     //check if all there bool variables returns true then honey is organic 
     if (beesState && temperatureState && humidityState && co2State && weightState && has_diseases) {
         hives[hiveId].isBeesStateOkay = true;
     } else {
         hives[hiveId].isBeesStateOkay = false;
     }
     return isBeesStateOkay;
   }
}



