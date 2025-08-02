#define _LIBC 
#include <unistd.h>
#include <string.h>

int putchar(int c) {
    return _write(1, &c, 1);
}

int puts(const char *s) {
    int ret = _write(1, s, strlen(s));
    putchar('\n');
    return ret;
}


