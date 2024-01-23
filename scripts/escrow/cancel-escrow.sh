#!/bin/sh

RIDER=$1
ID=$2

CANCEL_DATA='{"cancel":{"id": "'"$ID"'"}}'

$CHAIN tx wasm execute $ESCROW_CONTRACT_ADDRESS "$CANCEL_DATA" --from $RIDER --node $NODE --chain-id $CHAINID --gas auto --gas-adjustment 1.5 --gas-prices 0.025udmotus -b block -y

