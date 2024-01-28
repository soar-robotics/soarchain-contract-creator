#!/bin/sh

set -eux

locs=$(echo '"'$1'"' | jq -c 'split(",")')

$CHAIN query wasm contract-state smart $SUBSCRIPTION_CONTRACT_ADDRESS \
'{"list_multiple":{"locations":'$locs'}}' \
--node $NODE
