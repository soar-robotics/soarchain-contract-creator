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
		   ./scripts/subscription/deploy-subscription.sh \
		   ./scripts/subscription/init-subscription.sh \
		   ./scripts/subscription/subscribe.sh \
		   ./scripts/subscription/subscription-details.sh \
		   ./scripts/subscription/subscription-list.sh \
		   ./scripts/subscription/subscription-list-multiple.sh \
		   ./scripts/setup/configure-workspace.sh \
		   ./scripts/setup/add-master.sh \
		   ./scripts/setup/add-rider.sh \
		   ./scripts/setup/add-driver.sh \


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
# export CHAIN = soarchaind
# export NODE = http://164.92.252.231:26657
# export CHAINID = soarchaintestnet
# export DENOM = utmotus
# export ACCOUNT = rider

#######################
## Docker Container ###

start-node:
	./scripts/start-node.sh

stop-node:
	./scripts/stop-node.sh


export ESCROW_CONTRACT_ADDRESS = soar14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sg0qwca
export SUBSCRIPTION_CONTRACT_ADDRESS = 
export code = 1
export subscription_code = 2
export escrow-id = 1
export LOCK = 7645
export SECRET = 7645
export DEPOSIT = 45687
export LOCATION = istanbul
export MASTERACCOUNT = soarMasterAccount
export DRIVERACCOUNT = driver

#####################
## Add Keys ##

add-master:
	./scripts/setup/add-master.sh $(MASTERACCOUNT)

add-rider:
	./scripts/setup/add-rider.sh $(ACCOUNT)

add-driver:
	./scripts/setup/add-driver.sh $(DRIVERACCOUNT)

#####################
## Escrow Contract ##

deploy-escrow:
	./scripts/escrow/deploy-escrow.sh $(ACCOUNT)

init-escrow:
	./scripts/escrow/init-escrow.sh $(code) $(ACCOUNT)

create-escrow:
	./scripts/escrow/create-escrow.sh $(escrow-id) $(LOCK) $(DEPOSIT) $(DRIVERACCOUNT)

list-escrow:
	./scripts/escrow/list-escrow.sh

details-escrow:
	./scripts/escrow/details-escrow.sh $(escrow-id)

withdraw-escrow:
	./scripts/escrow/withdraw-escrow.sh $(escrow-id) $(SECRET)

cancel-escrow:
	./scripts/escrow/cancel-escrow.sh $(escrow-id)

#####################
## Subscription Contract ##

deploy-subscription:
	./scripts/subscription/deploy-subscription.sh

init-subscription:
	./scripts/subscription/init-subscription.sh $(subscription_code)

subscribe:
	./scripts/subscription/subscribe.sh $(from) $(nkn) $(location) 

subscription-details:
	./scripts/subscription/subscription-details.sh $(addr)

# ex: make subscription-list location=istanbul
subscription-list:
	./scripts/subscription/subscription-list.sh $(location)

# ex: make subscription-list-multiple locations=istanbul, ...
subscription-list-multiple:
	./scripts/subscription/subscription-list-multiple.sh $(locations)


##################
## Native Token ##

export tokentosend = 1000000000

send-token-to-account:
	./scripts/escrow/send-token.sh  $(driver-address) $(tokentosend)

send-token-to-contract:
	./scripts/escrow/send-token.sh  $(ESCROW_CONTRACT_ADDRESS) $(tokentosend)

#####################
## Setup Workspace ##

# Using this script Rust will be installed successfully,
# the script would be executable, and WebAssembly target will be added added.
install-rust:
	./scripts/setup/install-and-fix-rust-with-wasm.sh


##############################
## Pre-Deploy Configuration ##


# Execute this target once you update the code otherwise there is no need to build project.
build-escrow:
	./scripts/escrow/build-escrow.sh "$(shell pwd)/escrow"


#This script likely contains instructions for compiling the escrow module, handling dependencies,
# and ensuring that the compiled code is ready for integration.
compile-escrow:
	./scripts/escrow/compile-escrow.sh "$(shell pwd)/escrow"


