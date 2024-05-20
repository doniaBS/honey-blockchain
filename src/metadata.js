const metadataContainer = document.getElementById('metadata-container');

function displayMetadata(metadata) {
  // Clear the container before displaying new data (optional)
  metadataContainer.innerHTML = '';

  // Create elements to display each data point
  const beekeeperIdEl = document.createElement('p');
  const beekeeperAddressEl = document.createElement('p');
  const hiveIdEl = document.createElement('p');
  const temperatureEl = document.createElement('p');
  const humidityEl = document.createElement('p');
  const co2El = document.createElement('p');
  const weightEl = document.createElement('p');
  const gpsEl = document.createElement('p');
  const hasPestsEl = document.createElement('p');
  const hasDiseasesEl = document.createElement('p');
  const timestampEl = document.createElement('p');

  // Set content for each element
  beekeeperIdEl.textContent = `Beekeeper ID: ${metadata.beekeeper_id}`;
  beekeeperAddressEl.textContent = `Beekeeper Address: ${metadata.beekeeper_address}`;
  hiveIdEl.textContent = `Hive ID: ${metadata.hive_id}`;
  temperatureEl.textContent = `Temperature: ${metadata.temperature}°C`;
  humidityEl.textContent = `Humidity: ${metadata.humidity}%`;
  co2El.textContent = `CO2: ${metadata.co2}ppm`;
  weightEl.textContent = `Weight: ${metadata.weight}kg`;
  gpsEl.textContent = `GPS location: ${metadata.gps_location}`;
  hasPestsEl.textContent = `Has pests: ${metadata.hasPests}`;
  hasDiseasesEl.textContent = `Has diseases: ${metadata.hasDiseases}`;
  timestampEl.textContent = `Timestamp: ${metadata.timestamp}`;


  // Append elements to the container
  metadataContainer.appendChild(beekeeperIdEl);
  metadataContainer.appendChild(beekeeperAddressEl);
  metadataContainer.appendChild(hiveIdEl);
  metadataContainer.appendChild(temperatureEl);
  metadataContainer.appendChild(humidityEl);
  metadataContainer.appendChild(co2El);
  metadataContainer.appendChild(weightEl);
  metadataContainer.appendChild(gpsEl);
  metadataContainer.appendChild(hasPestsEl);
  metadataContainer.appendChild(hasDiseasesEl);
  metadataContainer.appendChild(timestampEl);
}

// This function is called from offChainService.py
function receiveMetadata(metadata) {
  displayMetadata(JSON.parse(metadata)); // Parse received data as JSON
  console.log(JSON.parse(metadata))
}
