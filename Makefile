CC_amd64 = gcc
CC_arm64 = aarch64-linux-gnu-gcc

CFLAGS = -std=c99 -pedantic -Os -Wall -Werror -static

ARCHES = amd64 arm64
BINS = $(addprefix bin/pause-linux-,$(ARCHES))

DESTDIR = /usr/local
INSTALL = install
HELP2MAN = help2man -N

STRIP_amd64 = strip
STRIP_arm64 = aarch64-linux-gnu-strip

all: $(BINS)

bin/pause-linux-amd64: pause.c | bin
	$(CC_amd64) $(CFLAGS) -o $@ $<
	$(STRIP_amd64) $@

bin/pause-linux-arm64: pause.c | bin
	$(CC_arm64) $(CFLAGS) -o $@ $<
	$(STRIP_arm64) $@

bin:
	mkdir -p bin

pause.1.gz: bin/pause-linux-amd64
	$(HELP2MAN) --help-option="-h" --version-option="-v" ./bin/pause-linux-amd64 | gzip -9 > $@

install: bin/pause-linux-amd64 pause.1.gz
	$(INSTALL) bin/pause-linux-amd64 $(DESTDIR)/bin/pause
	$(INSTALL) pause.1.gz $(DESTDIR)/share/man/man1

install-strip: bin/pause-linux-amd64 pause.1.gz
	$(INSTALL) --strip bin/pause-linux-amd64 $(DESTDIR)/bin/pause
	$(INSTALL) pause.1.gz $(DESTDIR)/share/man/man1

clean:
	rm -rf bin pause.1.gz

.PHONY: all clean install install-strip
