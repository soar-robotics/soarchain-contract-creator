#!/bin/sh

CODE_ID=$1

INIT='{'\
'"denom": "'"$DENOM"'"'\
'}';

$CHAIN tx wasm instantiate $CODE_ID "$INIT" --label "SOARCHAIN ESCROW INIT" --no-admin --from $ACCOUNT --node $NODE --chain-id $CHAINID --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y


$CHAIN tx bank send $($CHAIN  keys show -a soarMasterAccount) $ESCROW_CONTRACT_ADDRESS 100000$DENOM --chain-id $CHAINID --node $NODE --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y