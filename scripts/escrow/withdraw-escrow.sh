#!/bin/sh

RIDER=$1
ID=$2
SECRET=$3

WITHDRAW_DATA='{"withdraw":{"id": "'"$ID"'", "secret":"'"$SECRET"'"}}'

$CHAIN tx wasm execute $ESCROW_CONTRACT_ADDRESS "$WITHDRAW_DATA" --gas-prices 0.025udmotus --from $RIDER --gas auto --gas-adjustment 1.5 -b block -y