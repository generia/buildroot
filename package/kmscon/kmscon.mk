################################################################################
#
# kmscon
#
################################################################################

KMSCON_VERSION = 8
KMSCON_SITE = https://www.freedesktop.org/software/kmscon/releases
KMSCON_SOURCE = kmscon-$(KMSCON_VERSION).tar.xz
KMSCON_LICENSE = MIT
KMSCON_DEPENDENCIES = host-pkgconf mesa3d libxkbcommon xkeyboard-config libtsm eudev
KMSCON_AUTORECONF = YES

$(eval $(autotools-package))
