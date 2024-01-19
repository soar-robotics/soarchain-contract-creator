#!/bin/sh

soarchaind tx wasm store ./escrow/artifacts/escrow.wasm --from client --node $NODE --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y
