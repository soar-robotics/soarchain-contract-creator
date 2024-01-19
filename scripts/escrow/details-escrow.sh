#!/bin/sh

soarchaind query wasm contract-state smart $ESCROW_CONTRACT_ADDRESS '{"details":{"id":"'"$1"'"}}' --node $NODE
