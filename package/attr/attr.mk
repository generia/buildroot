################################################################################
#
# attr
#
################################################################################

ATTR_VERSION = 2.4.48
ATTR_SITE = http://download.savannah.gnu.org/releases/attr
ATTR_LICENSE = GPL-2.0+ (programs), LGPL-2.1+ (libraries)
ATTR_LICENSE_FILES = doc/COPYING doc/COPYING.LGPL

ATTR_INSTALL_STAGING = YES

ATTR_CONF_OPTS = --disable-nls
HOST_ATTR_CONF_OPTS = --disable-nls

# libtool: -rpath param does not work, copy shared lib manually
define HOST_ATTR_FIX_LIBTOOL_DYLIB_FILES
	cp $(HOST_ATTR_SRCDIR)/libattr/.libs/libattr*\.dylib $(HOST_DIR)/lib/
endef
HOST_ATTR_POST_INSTALL_HOOKS += HOST_ATTR_FIX_LIBTOOL_DYLIB_FILES


$(eval $(autotools-package))
$(eval $(host-autotools-package))
