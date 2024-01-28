#!/bin/bash

RIDER=$1

# Add a rider account key using the test keyring backend and secp256k1 algorithm
$CHAIN keys add $RIDER --recover

echo "----------------------- Transaction Result ------------------------"

# Query and display the balances of the rider account's address
$CHAIN q bank balances $($CHAIN keys show -a $RIDER)
