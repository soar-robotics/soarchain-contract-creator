#!/bin/sh

$CHAIN query wasm contract-state smart $SUBSCRIPTION_CONTRACT_ADDRESS \
'{"list":{"location":"'"$1"'"}}' \
--node $NODE
