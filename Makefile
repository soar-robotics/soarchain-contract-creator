
###########
## LOCAL ##
###########
export CHAIN = soarchaind
export NODE = http://localhost:26657
export CHAINID = soarchaindevnet
export DENOM = udmotus
export ACCOUNT = rider

############
## DEVNET ##
############
# export NODE = http://164.92.252.231:26657
# export CHAINID = soarchaintestnet
# export DENOM = utmotus
# export CHAIN = soarchaind
# export ACCOUNT = rider

#######################
## Docker Container ###

start-node:
	./scripts/start_node.sh

stop-node:
	./scripts/stop_node.sh


export ESCROW_CONTRACT_ADDRESS = soar14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sg0qwca
export code = 1

export rider-address = soar1ghfnkjlc5gxpldat7hm50tgggwc6l5h7ydwy2a
export escrow-id = 1
export driver-address = soar1ctvwnwl30getglarz2pp0gmnpggx4zznmlkv7j
export LOCK = 7645
export SECRET = 7645
export soarMasterAccount = soar1qt8myp9424ng6rv4fwf65u9a0ttfschw5j4sp8
export amount = 45687
export cw20Code = 2
export RIDER = rider

#####################
## Escrow Contract ##


deploy-escrow:
	./scripts/escrow/deploy-escrow.sh

init-escrow:
	./scripts/escrow/init-escrow.sh $(code) $(DENOM)

create-escrow:
	./scripts/escrow/create-escrow.sh $(rider-address) $(escrow-id) $(driver-address) $(LOCK) $(amount)

list-escrow:
	./scripts/escrow/list-escrow.sh

details-escrow:
	./scripts/escrow/details-escrow.sh $(escrow-id)

withdraw-escrow:
	./scripts/escrow/withdraw-escrow.sh $(RIDER) $(escrow-id) $(SECRET)

cancel-escrow:
	./scripts/escrow/cancel-escrow.sh $(rider-address) $(escrow-id)

##################
## Native Token ##

export tokentosend = 1000000000udmotus

send-token-to-account:
	./scripts/escrow/send-token.sh  $(soarMasterAccount) $(driver-address) $(tokentosend)

send-token-to-contract:
	./scripts/escrow/send-token.sh  $(soarMasterAccount) $(ESCROW_CONTRACT_ADDRESS) $(tokentosend)

###################
## CW20 Contract ##

build-cw20:
	./scripts/cw20/build-cw20.sh "$(shell pwd)/cw-plus"

compile-cw20:
	./scripts/cw20/compile-cw20.sh "$(shell pwd)/cw-plus"

deploy-cw20:
	./scripts/cw20/deploy-cw20.sh

init-cw20:
	./scripts/cw20/init-cw20.sh $(cw20Code)

###################
## Pre-Deploy Configuration ##



build-escrow:
	./scripts/build.sh "$(shell pwd)/escrow"

compile-escrow:
	./scripts/compile.sh "$(shell pwd)/escrow"


