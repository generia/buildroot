################################################################################
#
# apt
#
################################################################################

APT_VERSION = 1.5.y
APT_SITE = https://salsa.debian.org/apt-team/apt/repository/$(APT_VERSION)
APT_SOURCE = apt-$(APT_VERSION).tar.gz
APT_SOURCE_TARBALL = archive.tar.gz
APT_DEPENDENCIES = gnutls zlib bzip2 lz4 udev dpkg

APT_LICENSE = GPL-2.0+
APT_LICENSE_FILES = COPYING

APT_CONF_OPTS += -DWITH_CURL=OFF -DWITH_DOC=OFF -DDPKG_DATADIR=$(TARGET_DIR)/usr/share/dpkg


$(eval $(cmake-package))
