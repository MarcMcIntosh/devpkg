CFLAGS=-g -O2 -Wall -Wextra -Isrc -rdynamic -DNDEBUG -fsanitize=undefined $(OPTFLAGS)
LDFLAGS=$(OPTLIBS)

DESTDIR?=tmp
PREFIX?=/usr/local

SOURCES=$(wildcard src/**/*.c src/*.c)
OBJECTS=$(patsubst %.c,%.o,$(SOURCES))

TEST_SRC=$(wildcard tests/*_tests.c)
TESTS=$(patsubst %.c,%,$(TEST_SRC))

TARGET=bin/devpkg

all: $(TARGET) tests

dev: CFLAGS= -g -Wall -Isrc -Wall -Wextra -fsanitize=undefined $(OPTFLAGS)
dev: all

$(TARGET): CFLAGS += -fPIC
$(TARGET): build $(OBJECTS)

build:
	@mkdir -p build
	@mkdir -p bin
	@mkdir -p tmp

# The unit tests
.PHONY: tests
tests: LDLIBS += $(TARGET)
tests: $(TESTS)
	sh ./tests/runtests.sh

valgrind:
	VALGRIND="valgrind --log-file=/tmp/valgrind-%p.log" $(MAKE)


# The Cleaner
clean: 
	rm -rf build bin $(OBJECTS) $(TESTS)
	rm -f tests/tests.log
	find . -name "*.gc*" -exec rm {} \;
	rm -rf `find . -name "*.dSYM" -print`

# The install
install: all
	install -d $(DESTDIR) $(TESTS)
	install $(TARGET) $(DESTDIR)/$(PREFIX)/lib/

