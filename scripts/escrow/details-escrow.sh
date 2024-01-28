#!/bin/sh

ID=$1


# Perform the query
$CHAIN query wasm contract-state smart $ESCROW_CONTRACT_ADDRESS '{"details":{"id":"'"$ID"'"}}' \
--node $NODE \
--chain-id $CHAINID \
