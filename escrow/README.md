
# Ride Sharing and Escrow Smart Contract Guideline

This meta-contract acts as an escrow facilitator, allowing multiple users to autonomously initiate unique escrows. Each escrow transaction involves two users and is assigned a distinct identifier.

## Operation Overview

The rider, in their role as the creator, initiates an escrow by securing funds, designating a recipient, and implementing a lock in the form of a 4-digit f2a code containing letters (with 36^4 possibilities). Upon completing the ride, the rider provides the f2a code, unlocking the funds and transferring them to the driver's wallet. The rider, as the creator, retains the ability to utilize the cancel method, enabling them to annul the escrow and reclaim the initial deposit. Importantly, only the rider can invoke the cancel method, while anyone in possession of the secret key can execute the withdraw method.

## Prerequisites

1- Prior to commencing, detailed instructions are provided in our documentation at:
SoarChain Smart Contracts - [Before Starting](https://docs.soarchain.com/smart%20contracts/before-Starting)

2- Generate keys named "soarMasterAccount", "rider" and "driver" using soarchaind.

```bash
soarchaind keys add soarMasterAccount --recover --keyring-backend test --algo secp256k1
soarchaind keys add rider --recover --keyring-backend test --algo secp256k1
```

**Note:** Driver should be already registered into the soarchain blokchain. This means drivers have address.  

3- Install docker on the device

## Workflow Demystified

1- Run local node

* Clone the [soarchain-core](https://github.com/soar-robotics/soarchain-core)
* cd **soarchain-core** directory
* Run  ```./run_makefile.sh```

Note: The node can be run using Docker by creating a container. Follow the steps outlined below:

* Clone [soarchain-contract-creator](https://github.com/soar-robotics/soarchain-contract-creator.git)
* cd **soarchain-contract-creator** directory
* Run ```make start-node```

**Note:** Running ```make stop-node``` will stop the node

2- Once the node is operational, it's time to interact with the escrow smart contract by following the steps below:

* make deploy-escrow
* make init-escrow
* make create-escrow

Once escrow is created it will be queries by running:

* make list-escrow
* make details-escrow

With the escrow now established, we have the ability to:

1- Withdrow: This command is used to trigger the withdrawal functionality of the Escrow contract. Transferring funds from the escrow to the driver. The provided parameters, such as the escrow ID and secret, determine the specific withdrawal details.

* make withdraw-escrow

2- Cancel: The command make cancel-escrow is utilized to cancel an existing escrow transaction. This command triggers the cancellation functionality within the Escrow contract, allowing the cancellation of a previously initiated escrow. The parameters, such as the escrow ID, are provided to identify the specific escrow transaction to be canceled.

* make cancel-escrow

## Useful Commands

Alternatively Using the below command it is possible to send coins to the rider

``` make send-token-to-rider ```

OR to the related contract

``` make send-token-to-contract ```

The command make build-escrow is used to compile and build the Escrow contract

``` make build-escrow ```

The command make compile-escrow is used to compile the source code of the Escrow contract without building the executable. This step is typically performed during development to check for syntax errors and ensure that the code is ready for compilation and subsequent deployment.

``` make compile-escrow ```
