################################################################################
#
# dpkg
#
################################################################################

#https://salsa.debian.org/dpkg-team/dpkg/repository/stretch/archive.tar.gz
#https://salsa.debian.org/dpkg-team/dpkg/repository/1.18.x/archive.tar.gz
#DPKG_VERSION = stretch
#DPKG_SITE = https://salsa.debian.org/dpkg-team/dpkg
#DPKG_SITE_METHOD = git
DPKG_VERSION = 1.18.x
DPKG_SITE = https://salsa.debian.org/dpkg-team/dpkg/repository/$(DPKG_VERSION)
#DPKG_SOURCE = archive.tar.gz
DPKG_SOURCE = dpkg-$(DPKG_VERSION).tar.gz
DPKG_SOURCE_TARBALL = archive.tar.gz

# Uses PKG_CHECK_MODULES() in configure.ac
#DPKG_DEPENDENCIES = host-pkgconf libarchive
DPKG_LICENSE = GPL-2.0+
DPKG_LICENSE_FILES = COPYING
#DPKG_INSTALL_STAGING = YES
#DPKG_CONF_OPTS = --disable-curl
DPKG_AUTORECONF = YES

DPKG_CONF_ENV = DPKG_DEVEL_MODE=yes

define DPKG_CREATE_DIST_VERSION
	echo $(DPKG_VERSION) > $(DPKG_DIR)/.dist-version
endef

DPKG_POST_EXTRACT_HOOKS += DPKG_CREATE_DIST_VERSION

$(eval $(autotools-package))
