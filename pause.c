#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define APP_NAME     "pause"
#define APP_VERSION  "1.0.0"

int main(int argc, char *argv[])
{
	argv[0] = APP_NAME;

	/* Option parsing */
	int opt;

	while ((opt = getopt(argc, argv, "hv")) != -1) {
		switch (opt) {
		case 'h':
			printf("Usage: pause\n"
			       "  or:  pause [OPTION]\n"
			       "Suspend execution until a signal is received\n"
			       "that either terminates the process or causes\n"
			       "the invocation of a signal-catching function.\n"
			       "\n"
			       "  -v   output version and exit\n"
			       "  -h   output help and exit\n"
			);
			exit(EXIT_SUCCESS);
		case 'v':
			printf("%s (cli-tools) v%s\n", APP_NAME, APP_VERSION);
			exit(EXIT_SUCCESS);
		default:
			fprintf(stderr, "Try '%s -h' for more information.\n", APP_NAME);
			exit(EXIT_FAILURE);
		}
	}

	if (argc > optind) {
		fprintf(stderr, "%s: takes no arguments\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	/* Application logic */

	pause();

	exit(EXIT_SUCCESS);
}
