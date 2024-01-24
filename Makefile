# Makefile to make script files executable

# List of script files to make executable
SCRIPTS := ./scripts/escrow/build-escrow.sh \
           ./scripts/escrow/compile-escrow.sh \
		   ./scripts/setup/install-and-fix-rust-with-wasm.sh \
		   ./scripts/start-node.sh \
		   ./scripts/stop-node.sh \
		   ./scripts/escrow/cancel-escrow.sh \
		   ./scripts/escrow/create-escrow.sh \
		   ./scripts/escrow/deploy-escrow.sh \
		   ./scripts/escrow/details-escrow.sh \
		   ./scripts/escrow/init-escrow.sh \
		   ./scripts/escrow/list-escrow.sh \
		   ./scripts/escrow/send-token.sh \
		   ./scripts/escrow/withdraw-escrow.sh \

# Target to make all script files executable
make-scripts-executable:
	@chmod +x $(SCRIPTS)
	@echo "Script files are now executable."

# Default target
.PHONY: make-scripts-executable

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
	./scripts/start-node.sh

stop-node:
	./scripts/stop-node.sh


export ESCROW_CONTRACT_ADDRESS = soar14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sg0qwca
export code = 1

export escrow-id = 1
export LOCK = 7645
export SECRET = 7645
export DEPOSIT = 45687
export cw20Code = 2

#####################
## Escrow Contract ##


deploy-escrow:
	./scripts/escrow/deploy-escrow.sh

init-escrow:
	./scripts/escrow/init-escrow.sh $(code)

create-escrow:
	./scripts/escrow/create-escrow.sh $(escrow-id) $(LOCK) $(DEPOSIT)

list-escrow:
	./scripts/escrow/list-escrow.sh

details-escrow:
	./scripts/escrow/details-escrow.sh $(escrow-id)

withdraw-escrow:
	./scripts/escrow/withdraw-escrow.sh $(escrow-id) $(SECRET)

cancel-escrow:
	./scripts/escrow/cancel-escrow.sh $(escrow-id)

##################
## Native Token ##

export tokentosend = 1000000000

send-token-to-account:
	./scripts/escrow/send-token.sh  $(driver-address) $(tokentosend)

send-token-to-contract:
	./scripts/escrow/send-token.sh  $(ESCROW_CONTRACT_ADDRESS) $(tokentosend)


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


##############################
## Pre-Deploy Configuration ##


build-escrow:
	./scripts/escrow/build-escrow.sh "$(shell pwd)/escrow"

compile-escrow:
	./scripts/escrow/compile-escrow.sh "$(shell pwd)/escrow"


