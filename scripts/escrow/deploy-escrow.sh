#!/bin/sh

RIDER=$1

$CHAIN tx wasm store ./escrow/artifacts/escrow.wasm  \
    --from $RIDER \
    --node $NODE \
    --chain-id $CHAINID \
    --gas-prices 0.1$DENOM \
    --gas auto \
    --gas-adjustment 1.3 \
    -b block \
    -y