build: pause pause.1
	$(NOOP)

clean:
	$(RM) pause pause.man

install:
	install pause.1 /usr/local/share/man/man1/
	install --strip pause /usr/local/bin/

pause.1: pause
	help2man -N --help-option="-h" --version-option="-v" -o $@ ./pause
