################################################################################
#
# Cdrtools
#
################################################################################

CDRTOOLS_VERSION = 3.01
CDRTOOLS_SOURCE = cdrtools-$(CDRTOOLS_VERSION).tar.gz
CDRTOOLS_SITE = https://downloads.sourceforge.net/project/cdrtools

define HOST_CDRTOOLS_BUILD_CMDS
	echo "build cdrtools ..."
	$(HOST_MAKE_ENV) $(HOST_CDRTOOLS_MAKE_ENV) $(MAKE) $(HOST_CDRTOOLS_MAKE_OPTS) -C $(HOST_CDRTOOLS_SRCDIR)
endef

define HOST_CDRTOOLS_INSTALL_CMDS
	echo "install cdrtools ..."
	# TODO: 
	echo "$(INSTALL) -m 0755 $(@D)/stm32*.bin $(HOST_DIR)"
endef

CDRTOOLS_LICENSE = GPL-2.0
CDRTOOLS_LICENSE_FILES = COPYING

$(eval $(host-generic-package))
