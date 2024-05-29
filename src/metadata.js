// Establish WebSocket connection
const ws = new WebSocket('ws://localhost:8765');

ws.onmessage = function(event) {
    const received_data = JSON.parse(event.data);
    if (received_data.error) {
        displayError(received_data); // Access the error message directly
    } else {
        displayMetadata(received_data);
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

const messageContainer = document.getElementById('message-container');

function displayError(received_data) {
    // Clear the container before displaying new data (optional)
    messageContainer.innerHTML = '';
    // Display error message on the web page
    document.getElementById("error").innerHTML = `Error: ${received_data.error}`;
}

const metadataContainer = document.getElementById('metadata-container');

function displayMetadata(received_data) {
  // Clear the container before displaying new data (optional)
  metadataContainer.innerHTML = '';

  // Access each property and display it in the HTML elements
document.getElementById("beekeeper-id").innerHTML = `Beekeeper ID: ${received_data.beekeeper_id}`;
document.getElementById("beekeeper-address").innerHTML = `Beekeeper Address: ${received_data.beekeeper_address}`;
document.getElementById("hive-id").innerHTML = `Hive ID: ${received_data.hive_id}`;
document.getElementById("temperature").innerHTML = `Temperature: ${received_data.temperature}°C`;
document.getElementById("humidity").innerHTML = `Humidity: ${received_data.humidity}%`;
document.getElementById("co2").innerHTML = `CO2: ${received_data.co2}ppm`;
document.getElementById("weight").innerHTML = `Weight: ${received_data.weight}kg`;
document.getElementById("gps-location").innerHTML = `GPS location: ${received_data.gps_location}`;
document.getElementById("has-pests").innerHTML = `Has pests: ${received_data.has_pests}`;
document.getElementById("has-diseases").innerHTML = `Has diseases: ${received_data.has_diseases}`;
document.getElementById("timestamp").innerHTML = `Timestamp: ${received_data.timestamp}`; 
}
