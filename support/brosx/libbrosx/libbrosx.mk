################################################################################
#
# Libbrosx
#
# Simple glue library filling up things from glibc missing in Xcode/clang.
#
################################################################################

HOST_LIBBROSX_VERSION =

HOST_LIBBROSX_SOURCE_DIR = $(TOPDIR)/$(HOST_LIBBROSX_PKGDIR)
HOST_LIBBROSX_SOURCES = $(HOST_LIBBROSX_SOURCE_DIR)errno.c
HOST_LIBBROSX_LIBNAME = libbrosx.0.dylib
HOST_LIBBROSX_LIBNAME_NO_VERSION = libbrosx.dylib
HOST_LIBBROSX_LIB_BUILD = $(HOST_LIBBROSX_SRCDIR)$(HOST_LIBBROSX_LIBNAME)
HOST_LIBBROSX_LIB_INSTALL = $(HOST_DIR)/lib/$(HOST_LIBBROSX_LIBNAME)
HOST_LIBBROSX_LIB_INSTALL_NO_VERSION = $(HOST_DIR)/lib/$(HOST_LIBBROSX_LIBNAME_NO_VERSION)

HOST_LIBBROSX_CFLAGS = $(HOST_CFLAGS) -I$(HOST_LIBBROSX_SOURCE_DIR)include
HOST_LIBBROSX_LDFLAGS = $(HOST_LDFLAGS) \
	-arch x86_64 -arch i386 \
	-dynamiclib -compatibility_version 1 -current_version 1.0 -Wl,-single_module \
	-install_name  $(HOST_LIBBROSX_LIB_INSTALL)


LIBBROSX_LICENSE = GPL-2.0


define HOST_LIBBROSX_BUILD_CMDS
	$(HOSTCC) $(HOST_LIBBROSX_CFLAGS) $(HOST_LIBBROSX_SOURCES) $(HOST_LIBBROSX_LDFLAGS) -o $(HOST_LIBBROSX_LIB_BUILD)
endef

define HOST_LIBBROSX_INSTALL_CMDS
	$(INSTALL) -D -m 755 $(HOST_LIBBROSX_SOURCE_DIR)include/libbrosx.h $(HOST_DIR)/include/libbrosx.h
	$(INSTALL) -D -m 755 $(HOST_LIBBROSX_LIB_BUILD) $(HOST_LIBBROSX_LIB_INSTALL)
	ln -s -f $(HOST_LIBBROSX_LIB_INSTALL) $(HOST_LIBBROSX_LIB_INSTALL_NO_VERSION)	
endef

DEPENDENCIES_HOST_PREREQ += host-libbrosx

$(eval $(host-generic-package))
