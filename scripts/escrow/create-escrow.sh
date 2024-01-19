#!/bin/sh

FROM=$1
ID=$2
USER_B=$3
LOCK=$4
AMOUNT=$5

CREATE_CONTENT='{'\
'"id": "'$ID'",'\
'"user_b": "'"$(soarchaind keys show -a runner)"'",'\
'"lock": "'"$LOCK"'",'\
'"amount": "'"$AMOUNT"'"'\
'}';

ESCROW_EXECUTE='{ "create": '"$CREATE_CONTENT"'}';
soarchaind tx wasm execute $ESCROW_CONTRACT_ADDRESS "$ESCROW_EXECUTE" --node $NODE --chain-id $CHAINID --gas-prices 0.025udmotus --gas auto --gas-adjustment 1.5 --from client -b block -y

