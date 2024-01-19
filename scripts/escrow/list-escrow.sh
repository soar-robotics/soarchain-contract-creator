#!/bin/sh

soarchaind query wasm contract-state smart $ESCROW_CONTRACT_ADDRESS '{"list":{}}' --node $NODE