#!/bin/sh

ID=$1

CANCEL_DATA='{"cancel":{"id": "'"$ID"'"}}'

$CHAIN tx wasm execute $ESCROW_CONTRACT_ADDRESS "$CANCEL_DATA" --from $ACCOUNT --node $NODE --chain-id $CHAINID --gas auto --gas-adjustment 1.5 --gas-prices 0.025$DENOM -b block -y

