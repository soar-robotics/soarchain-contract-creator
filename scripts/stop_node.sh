#!/bin/sh

sudo docker kill soarchain-contract-creator-validator-1 && sudo docker rm soarchain-contract-creator-validator-1

echo '@@@ soarchain-contract-creator-validator-1 killed and removed'