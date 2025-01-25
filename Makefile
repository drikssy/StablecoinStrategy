# Phony targets
.PHONY: build clean test deploy install

script-upgrade:
	@echo "Upgrade proxy contract on $(NETWORK)..."
	forge script script/deploy/UpgradeStargates.s.sol --rpc-url $(NETWORK) --verify --optimize

script-withdraw:
	forge script script/deploy/WithdrawToReceiver.s.sol --rpc-url $(NETWORK) --verify --optimize