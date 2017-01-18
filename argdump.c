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
 */

#include <stdio.h>

int main(int argc, char *argv[])
{
	int i;
	for (i = 0; i < argc; i++) {
		printf("%s\n", argv[i]);
	}
	return 0;
}
