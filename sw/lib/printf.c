#define _LIBC 
#include <unistd.h>
#include <stdio.h>
#include <stdarg.h>

int printf(const char *__restrict s, ...) {
    static char tmp[120];
    va_list args;  
    va_start(args, s);  
    int ret = vsprintf(tmp, s, args);
    va_end(args);
    return _write(1, tmp, ret);
}