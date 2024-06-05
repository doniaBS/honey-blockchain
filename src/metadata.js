// Establish WebSocket connection
const ws = new WebSocket('ws://localhost:8765');
ws.onmessage = function(event) {
    try {
        const received_data = JSON.parse(event.data);

        if (received_data.beekeeper_address) {
            // It's metadata
            displayMetadata(received_data);
        } else if (received_data.bee_state !== undefined) {
            // It's blockchain data
            displayBlockchainData(received_data);
            console.log(received_data.bee_state);
            console.log(received_data.honey_quality);
        }
    } catch (e) {
        console.error("Error parsing received data:", e);
    }
};

ws.onerror = function(error) {
    console.error('WebSocket Error: ', error);
};
ws.onopen = function() {
    console.log('WebSocket connection established');
};
ws.onclose = function() {
    console.log('WebSocket connection closed');
};

function displayMetadata(received_data) {
  // Access each property and display it in the HTML elements
document.getElementById("beekeeper-address").innerHTML = `Beekeeper Address: ${received_data.beekeeper_address}`;
document.getElementById("beekeeper-id").innerHTML = `Beekeeper ID: ${received_data.beekeeper_id}`;
document.getElementById("hive-id").innerHTML = `Hive ID: ${received_data.hive_id}`;
document.getElementById("temperature").innerHTML = `Temperature: ${received_data.temperature} °C`;
document.getElementById("humidity").innerHTML = `Humidity: ${received_data.humidity} %`;
document.getElementById("co2").innerHTML = `CO2: ${received_data.co2} ppm`;
document.getElementById("weight").innerHTML = `Weight: ${received_data.weight} kg`;
document.getElementById("gps-location").innerHTML = `GPS location: ${received_data.gps_location}`;
document.getElementById("has-pests").innerHTML = `Has pests: ${received_data.hasPests}`;
document.getElementById("has-diseases").innerHTML = `Has diseases: ${received_data.hasDiseases}`;
document.getElementById("timestamp").innerHTML = `Timestamp: ${received_data.timestamp}`; 
}

function displayBlockchainData(received_data){
document.getElementById("bee-state").innerHTML = `Bees State (has diseases or not): ${received_data.bee_state}`;
document.getElementById("honey-organic").innerHTML = `Honey quality (organic or not): ${received_data.honey_quality}`;
document.getElementById("temp-state").innerHTML = `Temperature should be between 30°C and 35°C: ${received_data.temp_state}`;
document.getElementById("hum-state").innerHTML = `Humidity should be between 90% and 95%: ${received_data.hum_state}`;
document.getElementById("co2-state").innerHTML = `CO2 should be between 1000ppm and 4000ppm: ${received_data.co2_state}`;
document.getElementById("weight-state").innerHTML = `Weight should be between 30kg and 80kg: ${received_data.weight_state}`;
}
