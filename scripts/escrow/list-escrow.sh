#!/bin/sh


# Perform the query
$CHAIN query wasm contract-state smart $ESCROW_CONTRACT_ADDRESS '{"list":{}}' --node $NODE