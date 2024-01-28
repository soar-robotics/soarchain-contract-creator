#!/bin/bash

DRIVER=$1

# Add a driver account key using the test keyring backend and secp256k1 algorithm
$CHAIN keys add $DRIVER --recover

echo "----------------------- Transaction Result ------------------------"

# Query and display the balances of the driver account's address
$CHAIN q bank balances $($CHAIN keys show -a $DRIVER)
