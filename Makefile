PREFIX?=/usr/local

CFLAGS=-g -O2 -Wall -Wextra -fsanitize=undefined -I${PREFIX}/apr/include/apr-1

CFLAGS+=-I${PREFIX}/apr/include/apr-util-1

LDFLAGS=-L${PREFIX}/apr/lib -lapr-1 -pthread -laprutil-1

all: devpkg

devpkg: bstrlib.o db.o shell.o commands.o

install: all
	install -d ${DESTDIR}/${PREFIX}/bin/
	install -d devpkg ${DESTDIR}/${PREFIX}/bin

clean:
	rm -f *.o 
	rm -f devpkg
	rm -rf *.dSYM

