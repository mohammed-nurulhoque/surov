#include <sys/types.h>
#include <sys/stat.h>

#pragma clang diagnostic ignored "-Wint-conversion"

enum syscall {
    WRITE,
    KILL,
    GETPID,
    READ,
    SBRK,
    LSEEK,
    ISATTY,
    FSTAT,
    CLOSE,
    EXIT
};

extern void *syscall0(enum syscall);
extern void *syscall1(enum syscall, void *);
extern void *syscall2(enum syscall, void *, void *);
extern void *syscall3(enum syscall, void *, void *, void *);

ssize_t _write(int fd, const void *buf, size_t count) {
    return (ssize_t)syscall3(WRITE, fd, buf, count);
}

int _kill(pid_t pid, int sig) {
    return (int)syscall2(KILL, pid, sig);
}

pid_t _getpid(void) {
    return (pid_t)syscall0(GETPID);
}

ssize_t _read(int fd, void *buf, size_t count) {
    return (ssize_t)syscall3(READ, fd, buf, count);
}

void *_sbrk(intptr_t increment) {
    return syscall1(SBRK, increment);
}

off_t _lseek(int fd, off_t offset, int whence) {
    return (off_t)syscall3(LSEEK, fd, offset, whence);
}

int _isatty(int fd) {
    return (int)syscall1(ISATTY, fd);
}

int _fstat(int fd, struct stat *statbuf) {
    return (int)syscall2(FSTAT, fd, statbuf);
}

int _close(int fd) {
    return (int)syscall1(CLOSE, fd);
}

[[noreturn]] void _exit(int status) {
    syscall1(EXIT, status);
}

