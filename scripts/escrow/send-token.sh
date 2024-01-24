#!/bin/sh

RECEIPT=$1
AMOUNT=$2

$CHAIN tx bank send $($CHAIN  keys show -a soarMasterAccount) $RECEIPT $AMOUNT$DENOM --chain-id $CHAINID --node $NODE --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y

echo "----------------------- Transaction Result ------------------------"

$CHAIN q bank balances $RECEIPT