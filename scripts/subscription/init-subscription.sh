#!/bin/sh

CODE=$1

$CHAIN tx wasm instantiate $CODE {} \
--label "SOARCHAIN SUBSCRIPTION INIT" \
--no-admin \
--from soarMasterAccount /
--chain-id $CHAINID \
--gas-prices 0.1$DENOM \
--gas auto \
--gas-adjustment 1.3 \
--node $NODE \
-y \
