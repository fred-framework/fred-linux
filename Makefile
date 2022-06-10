BIN = fred-server
SRCS = $(wildcard *.c) $(wildcard **/*.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(OBJS:.o=.d)
FRED_PATH ?= /usr/

CFLAGS += -std=gnu99 -Wall -g
# 64-bit addresses is supported by FRED, but currently not by DART.
# Therefore, we stick with 32 bits C_M_AXI_MEM_BUS_ADDR_WIDTH even for ZynqM devices
# The second implication is that FRED server MUST BE compiled without the define `HW_TASKS_A64`, to make it compatible with 32 bits
# CPPFLAGS += -D LOG_GLOBAL_LEVEL=LOG_LEV_FULL -D HW_TASKS_A64
CPPFLAGS += -Wno-unused-but-set-variable -D LOG_GLOBAL_LEVEL=LOG_LEV_FULL

$(BIN): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

# include all dep makefiles generated using the next rule
-include $(DEPS)

# Pattern rule for generating makefiles rules based
# on headers includes dependencies using the C preprocessor
# %.d: %.c
# 	$(CPP) $< -MM -MT $(@:.d=.o) > $@

.PHONY: clean
clean:
	rm -f $(BIN) $(OBJS) $(DEPS)

install:
	mkdir -p ${FRED_PATH}/bin
	cp ${BIN} ${FRED_PATH}/bin
