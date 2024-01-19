#!/bin/sh

FROM=$1
ID=$2

CANCEL_DATA='{"cancel":{"id": "'"$ID"'"}}'

soarchaind tx wasm execute $ESCROW_CONTRACT_ADDRESS "$CANCEL_DATA" --from $ACCOUNT --node $NODE --chain-id $CHAINID --gas auto --gas-adjustment 1.5 --gas-prices 0.025udmotus -b block -y

