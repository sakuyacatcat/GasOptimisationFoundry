.PHONY: slot
slot:
	sol2uml storage src/GasOptimized.sol -c GasContract

.PHONY: test
test:
	forge test -vvv --gas-report

.PHONY: all
all: test slot
