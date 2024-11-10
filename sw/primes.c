#include <stdio.h>

int main() {
    volatile char *out = (char*)0x8000000;
    char primes[100] = {};
    for (int i=2; i<100; i++) {
        if (!primes[i]) {
            for (int j=i*2; j<100; j+=i)
                primes[j] = 1;
        }
    }
    for (int i=0; i<100; i++) {
        *out = primes[i] ? 'n' : 'p';
        if (i%10 == 0) *out = '\n';
    }
    return 0;
}
