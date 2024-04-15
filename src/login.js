// Include Web3.js library
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
      console.log('Beekeeper address (latest):', currentAccount);
   } else {
      console.log('No account connected to MetaMask.');
    }
  } catch (error) {
    console.error('Error requesting accounts:', error);
    // Handle errors appropriately, e.g., display an error message to the user
    alert('Error: Could not connect to MetaMask. Please try again.');
  }
});
