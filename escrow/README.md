
# Ride Sharing and Escrow Smart Contract Guideline

This meta-contract acts as an escrow facilitator, allowing multiple users to autonomously initiate unique escrows. Each escrow transaction involves two users and is assigned a distinct identifier.

## Operation Overview

The rider, in their role as the creator, initiates an escrow by securing funds, designating a recipient, and implementing a lock in the form of a 4-digit f2a code containing letters (with 36^4 possibilities). Upon completing the ride, the rider provides the f2a code, unlocking the funds and transferring them to the driver's wallet. The rider, as the creator, retains the ability to utilize the cancel method, enabling them to annul the escrow and reclaim the initial deposit. Importantly, only the rider can invoke the cancel method, while anyone in possession of the secret key can execute the withdraw method.

## Prerequisites

1- Prior to commencing, detailed instructions are provided in our documentation at:
SoarChain Smart Contracts - [Before Starting](https://docs.soarchain.com/smart%20contracts/before-Starting)

3- Install docker on the device

## Lunching Soarchain Node

1- Lunching a soarchain node

a. Local Node

* Clone the [soarchain-core](https://github.com/soar-robotics/soarchain-core)
* cd **soarchain-core** directory
* Run  ```./run_makefile.sh```

b. Docker Container

The node can be run using Docker by creating a container. Follow the steps outlined below:

* make start-node
* into node container :
  * Clone [soarchain-contract-creator](https://github.com/soar-robotics/soarchain-contract-creator.git)
  * cd **soarchain-contract-creator** directory
* make make-scripts-executable
* make add-master

Running ```bash make stop-node``` will stop the node

After ensuring the node is operational, we will proceed with the remaining operations within the SoarChain node container, following the steps outlined below:

## Workflow Demystified

1- Generate a cryptographic key named 'rider' using the SoarChain daemon (soarchaind). Riders are required to possess a wallet within the SoarChain network associated with this key.

* make add-rider

To initiate a ride request, the rider's wallet must have a sufficient balance.

# Optional: If there is access to a Motus account, the scripts can be updated using that account. If not, create a driver account using the following command

* make add-driver

**Note:** Drivers must be registered on the SoarChain network prior to participating. When a driver subscribes to ride requests through a ride-sharing application, riders will be presented with a list of available drivers. Subsequently, a rider can initiate an escrow request by sending a request to create escrow, along with the driver's address.

3- Now, it's time to interact with the escrow smart contract by following the steps below:

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

* make send-token-to-rider

OR to the related contract

* make send-token-to-contract

The command make build-escrow is used to compile and build the Escrow contract

* make build-escrow

The command make compile-escrow is used to compile the source code of the Escrow contract without building the executable. This step is typically performed during development to check for syntax errors and ensure that the code is ready for compilation and subsequent deployment.

* make compile-escrow
