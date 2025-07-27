long _write(int fd, const void *buf, long count);
char s[] = "Hello World!\n";
int main() {
    _write(1, s, sizeof(s));
    return 0;
}
