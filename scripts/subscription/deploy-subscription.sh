#!/bin/sh


$CHAIN tx wasm store ./subscription/artifacts/subscription.wasm  \
--from $ACCOUNT \
--node $NODE \
--chain-id $CHAINID \
--gas-prices 0.1$DENOM \
--gas auto \
--gas-adjustment 1.3 \
-b block \
-y
