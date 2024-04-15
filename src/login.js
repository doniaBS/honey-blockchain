const loginForm = document.getElementById('login-form');
const loginButton = document.getElementById('signin');

loginButton.addEventListener('click', async (event) => {
  event.preventDefault(); // Prevent default form submission behavior

  // Check for MetaMask availability
  if (!window.ethereum) {
    alert('Please install MetaMask to use this application.');
    return;
  }
  try {
    //Get the current account from MetaMask
    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
    const currentAccount = accounts[0]; // Get the first account from the array
    if (currentAccount) {
      console.log('Beekeeper address (latest):', currentAccount); // dispaly the beekeeper address from metamask

      const hashStorageJSON = await $.getJSON('HashStorage.json');
      const hashStorage = TruffleContract(hashStorageJSON);
      hashStorage.setProvider(window.ethereum);

      // Instantiate BeekeeperContract
      const beekeeperContractJSON = await $.getJSON('BeekeeperContract.json');
      const beekeeperContract = TruffleContract(beekeeperContractJSON);
      beekeeperContract.setProvider(window.ethereum);

      // Send beekeeper address to HashStorage contract
      await hashStorage.deployed().then(instance => {
        return instance.storeBeekeeperAddress(currentAccount, { from: currentAccount });
      });
      console.log('Beekeeper address stored in HashStorage contract:', currentAccount);

      // Send beekeeper address to BeekeeperContract
      await beekeeperContract.deployed().then(instance => {
        return instance.registerBeekeeperWithAddress(currentAccount, { from: currentAccount });
      });
      console.log('Beekeeper address registered in BeekeeperContract:', currentAccount);
   } else {
      console.log('No account connected to MetaMask.');
    }
  } catch (error) {
    console.error('Error requesting accounts:', error);
    // Handle errors appropriately, e.g., display an error message to the user
    alert('Error: Could not connect to MetaMask. Please try again.');
  }
});
