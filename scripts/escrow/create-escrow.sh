#!/bin/sh

ID=$1
LOCK=$2
AMOUNT=$3

$CHAIN tx bank send $($CHAIN  keys show -a rider) $ESCROW_CONTRACT_ADDRESS $AMOUNT$DENOM --chain-id $CHAINID --node $NODE --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y

CREATE_CONTENT='{'\
'"id": "'$ID'",'\
'"user_b": "'"$($CHAIN keys show -a driver)"'",'\
'"lock": "'"$LOCK"'",'\
'"amount": "'"$AMOUNT"'"'\
'}';

ESCROW_EXECUTE='{ "create": '"$CREATE_CONTENT"'}';

$CHAIN tx wasm execute $ESCROW_CONTRACT_ADDRESS "$ESCROW_EXECUTE" --node $NODE --chain-id $CHAINID --gas-prices 0.025$DENOM --gas auto --gas-adjustment 1.5 --from $ACCOUNT -b block -y
