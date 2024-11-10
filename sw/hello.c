char *msg = "Hello World!";
int main() {
    volatile char *out = (char*)0x8000000;
    for (char *c = msg; *c; c++)
        *out = *c;
}
