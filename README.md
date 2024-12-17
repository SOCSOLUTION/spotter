
---
# Hardhat Project with Upgradeable Contracts

This project demonstrates a Hardhat-based Ethereum development environment with three smart contracts. Two of the contracts, `SixenseUpgradablePreSale` and `SpoterUpgradablePreSale`, are upgradeable using the OpenZeppelin Upgrades plugin. The third contract, `SpotterToken`, is a standard ERC-20 token.

## Table of Contents

- [Installation](#installation)
- [Contracts](#contracts)
- [Tasks](#tasks)
- [Testing](#testing)
- [Deployment](#deployment)
- [Upgrade Process](#upgrade-process)

## Installation

Clone the repository and install dependencies:

```bash
git clone https://github.com/SOCSOLUTION/spotter
cd spotter
npm install
```

To install Hardhat:

```bash
npm install --save-dev hardhat
```

## Contracts

### SixenseUpgradablePreSale

A presale contract for the Sixense project, upgradeable using OpenZeppelin's proxy pattern.

### SpoterUpgradablePreSale

A presale contract for the Spotter project, also upgradeable with OpenZeppelin's proxy pattern.

### SpotterToken

A standard ERC-20 token contract used for the Spotter project.

## Tasks

Useful Hardhat tasks:

- **Help:** `npx hardhat help`
- **Test:** `npx hardhat test`
- **Gas Report:** `REPORT_GAS=true npx hardhat test`
- **Run Node:** `npx hardhat node`
- **Deploy Contracts:** `npx hardhat run scripts/deploy.js`

## Testing

Run tests:

```bash
npx hardhat test
```

For gas reports:

```bash
REPORT_GAS=true npx hardhat test
```

## Deployment

Deploy contracts using:

```bash
npx hardhat run scripts/deploy.js --network <network-name>
```

Replace `<network-name>` with the desired network (e.g.`mainnet`).

## Upgrade Process

To upgrade an upgradeable contract:

1. Deploy the new version (e.g., `SixenseUpgradablePreSaleV2`).
2. Use OpenZeppelin’s upgrade plugin to upgrade:

   ```bash
   npx hardhat upgrade <contract-name> --network <network-name>
   ```

The contract will be upgraded without changing its address or state.

---