/*
 * errno.c
 *
 * Suppoort for Glibc extensions
 * See also https://www.gnu.org/software/gnulib/manual/html_node/Glibc-errno_002eh.html#Glibc-errno_002eh
 */
#include <string.h>
#include "stdio.h"
#include <libbrosx.h>

/* The full and simple forms of the name with which the program was
   invoked.  These variables are set up automatically at startup based on
   the value of argv[0].  */
char *program_invocation_name;
char *program_invocation_short_name;

void brosx_set_program_invocation(int argc, char *argv[]) {
	char *program_name = NULL;
	if (argc > 0) {
		program_name = argv[0];
	}
	brosx_set_program_invocation_name(program_name);
}

void brosx_set_program_invocation_name(char *program_name) {
    /* Update what we use for messages.  */
	program_invocation_name = program_name;
	if (program_name) {
		program_invocation_short_name = strrchr (program_name, '/');
		if (program_invocation_short_name) {
			program_invocation_short_name++;
		}
	}
}
