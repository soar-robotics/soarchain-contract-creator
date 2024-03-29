#!/bin/sh

ID=$1
SECRET=$2

WITHDRAW_DATA='{"withdraw":{"id": "'"$ID"'", "secret":"'"$SECRET"'"}}'

$CHAIN tx wasm execute $ESCROW_CONTRACT_ADDRESS "$WITHDRAW_DATA" --gas-prices 0.025$DENOM --from $ACCOUNT --node $NODE --chain-id $CHAINID --gas auto --gas-adjustment 1.5 -b block -y