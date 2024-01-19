#!/bin/sh

CODE_ID=$1

json_msg='{"name":"soarchain","symbol":"soar","decimals":8,"initial_balances":[{"address":"'"$(soarchaind keys show -a client)"'","amount":"1234567"}]}'


$CHAIN tx wasm instantiate $CODE_ID "$json_msg" --label "SOARCHAIN CW20 INIT" --no-admin --from $ACCOUNT --node $NODE --chain-id $CHAINID --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y