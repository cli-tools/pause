SHELL = /bin/sh
ALL = pause pause.1
DESTDIR = /usr/local
INSTALL = install
HELP2MAN = help2man -N

build: $(ALL)
	$(NOOP)

clean:
	$(RM) $(ALL)

install: $(ALL)
	$(INSTALL) pause $(DESTDIR)/bin
	$(INSTALL) pause.1 $(DESTDIR)/share/man/man1

install-strip: $(ALL)
	$(INSTALL) --strip pause $(DESTDIR)/bin
	$(INSTALL) pause.1.gz $(DESTDIR)/share/man/man1

%.1 : %
	$(HELP2MAN) --help-option="-h" --version-option="-v" -o $@ ./$^
