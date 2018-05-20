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

APT_CONF_OPTS += -DWITH_CURL=OFF -DWITH_DOC=OFF -DDPKG_DATADIR=/usr/share/dpkg
APT_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug "-DCMAKE_CXX_FLAGS_DEBUG=-g -O0"
ifeq ($(BR2_i386),y)
	APT_CONF_OPTS += -DCOMMON_ARCH=i386
endif
ifeq ($(BR2_x86_64),y)
	APT_CONF_OPTS += -DCOMMON_ARCH=amd64
endif


define APT_INSTALL_SOURCES_LIST
	$(INSTALL) -D -m 644 package/apt/sources.list \
		$(TARGET_DIR)/etc/apt/sources.list
	$(INSTALL) -D -m 644 package/apt/status \
		$(TARGET_DIR)/var/lib/dpkg/status
endef

APT_POST_INSTALL_TARGET_HOOKS += APT_INSTALL_SOURCES_LIST

$(eval $(cmake-package))
