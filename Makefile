.PHONY: all test clean

DUB := dub
BIN := grd
TEST_BIN := grd-test-library

# default to a release build, override with BUILD=debug
ifeq (,$(BUILD))
BUILD=release
endif

ifneq ($(BUILD),release)
	ifneq ($(BUILD),debug)
		$(error Unrecognized BUILD=$(BUILD), must be 'debug' or 'release')
	endif
	ENABLE_DEBUG := 1
endif

ifdef ENABLE_DEBUG
override BUILD = debug
endif

all: build

build:
	$(DUB) build -b $(BUILD)

test: unittest integration_test

unittest:
	$(DUB) test

integration_test:
	$(DUB) test --main-file tests/cli.d

clean:
	$(RM) $(BIN) $(TEST_BIN)
	$(DUB) clean
