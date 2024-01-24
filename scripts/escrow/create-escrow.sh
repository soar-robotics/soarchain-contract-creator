#!/bin/sh

$CHAIN tx bank send $($CHAIN  keys show -a $soarMasterAccount) $ESCROW_CONTRACT_ADDRESS 100000$DENOM --chain-id $CHAINID --node $NODE --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y

RIDER=$1
ID=$2
DRIVER=$3
LOCK=$4
AMOUNT=$5

CREATE_CONTENT='{'\
'"id": "'$ID'",'\
'"user_b": "'"$($CHAIN keys show -a $DRIVER)"'",'\
'"lock": "'"$LOCK"'",'\
'"amount": "'"$AMOUNT"'"'\
'}';

ESCROW_EXECUTE='{ "create": '"$CREATE_CONTENT"'}';

$CHAIN tx wasm execute $ESCROW_CONTRACT_ADDRESS "$ESCROW_EXECUTE" --node $NODE --chain-id $CHAINID --gas-prices 0.025udmotus --gas auto --gas-adjustment 1.5 --from $RIDER -b block -y

