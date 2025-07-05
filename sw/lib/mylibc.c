#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

int printf(const char *__restrict s, ...) {
    // static char tmp[120];
    // va_list args;  
    // va_start(args, s);  
    // int ret = vsprintf(tmp, s, args);
    // va_end(args);
    return _write(1, s, 1);
}

int puts(const char *s) {
    int len = strlen(s);
    int ret = _write(1, s, strlen(s));
    putchar('\n');
    return ret;
}

int putchar(int c) {
    return _write(1, &c, 1);
}

int time(int *p) {
    unsigned long cycles;  
    __asm__ volatile ("rdcycle %0" : "=r" (cycles));
    cycles >>= 16;
    if (p) *p = cycles;
    return cycles;
}



