################################################################################
#
# Cdrtools (mkisoimage)
#
# NOTE: 
#   This builds only "mkisofs" as a drop-in replacement of the outdated
#   Cdrkit genisoimage.
#
################################################################################

CDRTOOLS_VERSION = 3.01
CDRTOOLS_SOURCE = cdrtools-$(CDRTOOLS_VERSION).tar.gz
CDRTOOLS_SITE = https://downloads.sourceforge.net/project/cdrtools

define HOST_CDRTOOLS_BUILD_CMDS
	# build all (NOTE: parallel make is failing)
	$(HOST_MAKE_ENV) $(HOST_CDRTOOLS_MAKE_ENV) make -C $(HOST_CDRTOOLS_SRCDIR)
endef

define HOST_CDRTOOLS_INSTALL_CMDS
	# install mkisofs only
	$(HOST_MAKE_ENV) $(HOST_CDRTOOLS_MAKE_ENV) $(MAKE) INS_BASE=$(HOST_DIR) install -C $(HOST_CDRTOOLS_SRCDIR)mkisofs
	# link to genisoimage
	ln -s -f $(HOST_DIR)/bin/mkisofs $(HOST_DIR)/bin/genisoimage
endef

CDRTOOLS_LICENSE = GPL-2.0
CDRTOOLS_LICENSE_FILES = COPYING

$(eval $(host-generic-package))
