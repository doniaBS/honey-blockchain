// Include Web3.js library
const web3 = new Web3(window.ethereum);

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
    const currentAccount  = await web3.eth.requestAccounts();
    if (currentAccount) {
      console.log('Beekeeper address (latest):', currentAccount);

    // Your logic to proceed with the beekeeper address (e.g., display or send for data retrieval)
    // ... your code here ...
   } else {
      console.log('No account connected to MetaMask.');
    }
  } catch (error) {
    console.error('Error requesting accounts:', error);
    // Handle errors appropriately, e.g., display an error message to the user
    alert('Error: Could not connect to MetaMask. Please try again.');
  }
});
