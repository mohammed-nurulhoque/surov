#include <sys/types.h>
#include <sys/stat.h>
#include <machine/syscall.h>

#pragma clang diagnostic ignored "-Wint-conversion"
#pragma GCC diagnostic ignored "-Wint-conversion"

extern void *syscall0(int syscall);
extern void *syscall1(int syscall, void *);
extern void *syscall2(int syscall, void *, void *);
extern void *syscall3(int syscall, void *, void *, void *);

// ssize_t puts(int fd, const void *buf, size_t count) {
//     return (ssize_t)syscall3(PUTS, fd, buf, count);
// }

ssize_t _write(int fd, const void *buf, size_t count) {
    return (ssize_t)syscall3(SYS_write, fd, buf, count);
}

ssize_t _read(int fd, void *buf, size_t count) {
    return (ssize_t)syscall3(SYS_read, fd, buf, count);
}

void *_sbrk(intptr_t increment) {
    return syscall1(SYS_brk, increment);
}

off_t _lseek(int fd, off_t offset, int whence) {
    return (off_t)syscall3(SYS_lseek, fd, offset, whence);
}

int _isatty(int fd) {
    return (int)syscall1(SEMIHOST_istty, fd);
}

int _fstat(int fd, struct stat *statbuf) {
    return (int)syscall2(SYS_fstat, fd, statbuf);
}

int _close(int fd) {
    return (int)syscall1(SYS_close, fd);
}

[[noreturn]] void _exit(int status) {
    syscall1(SYS_exit, status);
}

