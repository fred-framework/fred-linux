BIN = fred-server
SRCS = $(wildcard *.c) $(wildcard **/*.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(OBJS:.o=.d)
FRED_PATH ?= /usr/

CFLAGS += -std=gnu99 -Wall -g
# CPPFLAGS += -D LOG_GLOBAL_LEVEL=LOG_LEV_FULL -D HW_TASKS_A64
CPPFLAGS += -Wno-unused-but-set-variable -D LOG_GLOBAL_LEVEL=LOG_LEV_FULL -D HW_TASKS_A64"

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
