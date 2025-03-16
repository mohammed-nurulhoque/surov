#include <string.h>
#include <machine/syscall.h>
#include <sys/unistd.h>
#include <stdio.h>

int main() {
    char s[8] = {};
    sprintf(s, "Hello World %d\n", 16);
    print_str(s);
    return 0;
}
