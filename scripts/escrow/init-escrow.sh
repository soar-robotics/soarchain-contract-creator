#!/bin/sh

CODE_ID=$1
INIT={}

$CHAIN tx wasm instantiate $CODE_ID "$INIT" --label "SOARCHAIN ESCROW INIT" --no-admin --from $ACCOUNT --node $NODE --chain-id $CHAINID --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y

