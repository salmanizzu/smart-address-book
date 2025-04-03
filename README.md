# Smart Address Book

A simple yet functional smart contract project built with Solidity and Foundry. This project demonstrates how to build, deploy, and test a decentralized address book on the Ethereum blockchain.

## Overview

The **Smart Address Book** allows users to store their name and favorite number on-chain. The contract enforces ownership to prevent unauthorized updates, making it a minimal yet effective demonstration of state management, events, and access control in Solidity.

## Smart Contract

### `SmartAddressBook.sol`

- Users can:
  - Add their name and favorite number
  - Retrieve their own favorite number
- The contract **owner** (the deploying address) can:
  - Update the name and favorite number for their own entry
- Emits an event when a new member is added
- Uses `modifier onlyOwner` and custom errors for strict access control

## Testing

### `SmartAddressBook.t.sol`

- Built with [Foundry](https://book.getfoundry.sh/)
- Covers:
  - Adding a person and validating stored data
  - Reverting when unauthorized addresses try to update data
  - Requiring non-empty names
  - Testing edge cases like very large numbers
  - Event emission verification

Run the tests with:
```bash
forge test
```

## Deployment

### `DeploySmartAddressBook.s.sol`

Deploy the contract with:
```bash
forge script script/DeploySmartAddressBook.s.sol:DeploySmartAddressBook --broadcast --rpc-url <YOUR_RPC_URL>
```

## Project Structure

```
├── src/
│   └── SmartAddressBook.sol        # The main contract
├── script/
│   └── DeploySmartAddressBook.s.sol # Script for deployment
├── test/
│   └── SmartAddressBook.t.sol      # Comprehensive test suite
```

## 🛠 Tech Stack

- **Solidity** `^0.8.24`
- **Foundry** (Forge, Cast)
- **Ethereum** Smart Contracts

## License

This project is licensed under the [MIT License](./LICENSE).

---

### Connect

Made with ❤️ by Salman "Izzy" Izzuddin  
Feel free to reach out for collaboration or questions!