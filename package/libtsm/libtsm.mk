################################################################################
#
# libtsm
#
################################################################################

LIBTSM_VERSION = 3
LIBTSM_SITE = https://www.freedesktop.org/software/kmscon/releases
LIBTSM_SOURCE = libtsm-$(LIBTSM_VERSION).tar.xz
LIBTSM_LICENSE = MIT
LIBTSM_INSTALL_STAGING = YES
LIBTSM_DEPENDENCIES = host-pkgconf
LIBTSM_AUTORECONF = YES

$(eval $(autotools-package))
