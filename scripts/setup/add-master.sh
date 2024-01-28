#!/bin/bash


MASTER=$1

# Add a master account key using the test keyring backend and secp256k1 algorithm
$CHAIN keys add $MASTER --recover

echo "----------------------- Transaction Result ------------------------"

# Query and display the balances of the master account's address
$CHAIN q bank balances $($CHAIN keys show -a $MASTER)
