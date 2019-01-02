#include_next <sys/xattr.h>

#if defined(__APPLE__)
static inline ssize_t _listxattr(const char *path, char *namebuf, size_t size) {
    return listxattr(path, namebuf, size, 0);
}
static inline ssize_t _llistxattr(const char *path, char *namebuf, size_t size) {
    return listxattr(path, namebuf, size, XATTR_NOFOLLOW);
}

static inline ssize_t _flistxattr(int fd, char *namebuf, size_t size) {
    return flistxattr(fd, namebuf, size, 0);
}

static inline ssize_t _getxattr (const char *path, const char *name, void *value, size_t size) {
    return getxattr(path, name, value, size, 0, 0);
}
static inline ssize_t _lgetxattr (const char *path, const char *name, void *value, size_t size) {
    return getxattr(path, name, value, size, 0, XATTR_NOFOLLOW);
}
static inline ssize_t _fgetxattr (int filedes, const char *name, void *value, size_t size) {
    return fgetxattr(filedes, name, value, size, 0, 0);
}

// [fl]setxattr: Both OS X and Linux define XATTR_CREATE and XATTR_REPLACE for the last option.
static inline int _setxattr(const char *path, const char *name, const void *value, size_t size, int flags) {
    return setxattr(path, name, value, size, 0, flags);
}
static inline int _lsetxattr(const char *path, const char *name, const void *value, size_t size, int flags) {
    return setxattr(path, name, value, size, 0, flags & XATTR_NOFOLLOW);
}
static inline int _fsetxattr(int filedes, const char *name, const void *value, size_t size, int flags) {
    return fsetxattr(filedes, name, value, size, 0, flags);
}

static inline int _removexattr(const char *path, const char *name) {
    return removexattr(path, name, 0);
}
static inline int _lremovexattr(const char *path, const char *name) {
    return removexattr(path, name, XATTR_NOFOLLOW);
}
static inline int _fremovexattr(int filedes, const char *name) {
    return fremovexattr(filedes, name, 0);
}
#elif defined(__linux__)
#define _listxattr(path, list, size) listxattr(path, list, size)
#define _llistxattr(path, list, size) llistxattr(path, list, size)
#define _flistxattr(fd, list, size) flistxattr(fd, list, size)

#define _getxattr(path, name, value, size)  getxattr(path, name, value, size)
#define _lgetxattr(path, name, value, size) lgetxattr(path, name, value, size)
#define _fgetxattr(fd, name, value, size)   fgetxattr(fd, name, value, size)

#define _setxattr(path, name, value, size, flags)   setxattr(path, name, value, size, flags)
#define _lsetxattr(path, name, value, size, flags)  lsetxattr(path, name, value, size, flags)
#define _fsetxattr(fd, name, value, size, flags)    fsetxattr(fd, name, value, size, flags)

#define _removexattr(path, name)    removexattr(path, name)
#define _lremovexattr(path, name)   lremovexattr(path, name)
#define _fremovexattr(fd, name)     fremovexattr(fd, name)

#endif
