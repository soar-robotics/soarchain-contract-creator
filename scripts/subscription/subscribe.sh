#!/bin/sh

DRIVER=$1
TIME=$2
LOCATION=$3

json_msg='{"subscribe":{"nkn_addr":"'"$DRIVER"'","location":"'"$LOCATION"'"}}'

$CHAIN tx wasm execute $SUBSCRIPTION_CONTRACT_ADDRESS \
"$json_msg" \
--from $DRIVER \
--gas auto \
--gas-adjustment 1.3 \
--gas-prices 0.1$DENOM \
--chain-id $CHAINID \
--node $NODE \
-y