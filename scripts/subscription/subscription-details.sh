#!/bin/sh

$CHAIN query wasm contract-state smart $SUBSCRIPTION_CONTRACT_ADDRESS \
'{"details":{"address":"'"$1"'"}}' \
--node $NODE
