/* argdump.c
 *
 * This program simply dumps the arguments it receives.
 *
 * Useful to verify what is happening with your command line.
 *
 * Example:
 *
 * 	$ ./argdump <(echo "What does this do?")
 * 	./argdump
 *	/dev/fd/65
 *
 *	$ ARGDUMP=ascii ./argdump "$(echo -e 'with\ttab')"
 *	./argdump
 *	with^Itab
 */

#include <stdio.h>
#include <string.h>

int dump_argument(const char *arg)
{
	char c;
	while ((c = *arg)) {
		if (c < 0) {
			putchar('^');
			putchar('@');
		}
		else if (c <= 26) {
			putchar('^');
			putchar('A' + c - 1);
		}
		else if (c <= 31) {
			putchar('^');
			switch (c) {
				case 27: putchar('['); break;
				case 28: putchar('\\'); break;
				case 29: putchar(']'); break;
				case 30: putchar('^'); break;
				case 31: putchar('_'); break;
			}
		}
		else if (c == 127) {
			putchar('^');
			putchar('?');
		}
		else {
			putchar(c);
		}
		arg++;
	}
	putchar('\n');

	/* Return an (int) to have the same signature as puts(3) */
	return 0;
}

char *get_options_string(char *env[])
{
	int i;

	for (i = 0; env[i]; i++) {
		if (strstr(env[i], "ARGDUMP=") == env[i]) {
			return env[i];
		}
	}
	return NULL;
}

int main(int argc, char *argv[], char *env[])
{
	int i;
	char *options_string;
	int (*dumper)(const char *s);

	options_string = get_options_string(env);
	if (options_string && strcmp(options_string, "ARGDUMP=ascii") == 0) {
		/* Assume that the terminal works with ASCII */
		dumper = dump_argument;
	}
	else {
		dumper = puts;
	}

	for (i = 0; i < argc; i++) {
		printf("%d -> ", i);
		dumper(argv[i]);
	}

	return 0;
}
