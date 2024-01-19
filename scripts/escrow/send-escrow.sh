#!/bin/sh

SENDER=$1
RECEIPT=$2
AMOUNT=$3

soarchaind tx bank send $SENDER $RECEIPT $AMOUNT --gas-prices 0.1$DENOM --gas auto --gas-adjustment 1.3 -b block -y