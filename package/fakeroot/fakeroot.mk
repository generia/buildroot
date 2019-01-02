################################################################################
#
# fakeroot
#
################################################################################

#FAKEROOT_VERSION = 1.20.2
#FAKEROOT_SOURCE = fakeroot_$(FAKEROOT_VERSION).orig.tar.bz2
#FAKEROOT_SITE = http://snapshot.debian.org/archive/debian/20141005T221953Z/pool/main/f/fakeroot

FAKEROOT_VERSION = 3.3
FAKEROOT_SOURCE = macosx-v$(FAKEROOT_VERSION).tar.gz
FAKEROOT_SITE = https://github.com/mackyle/fakeroot/archive

BR_NO_CHECK_HASH_FOR += $(FAKEROOT_SOURCE)

HOST_FAKEROOT_DEPENDENCIES = host-acl host-m4

define HOST_FAKEROOT_BOOTSTRAP_HOOK
	@$(call MESSAGE,"Bootstrapping")
	if [ ! -f $($(PKG)_SRCDIR)configure ]; then (cd $($(PKG)_SRCDIR); ./bootstrap); else echo "bootstrapping already done, skipping ..."; fi;
endef

HOST_FAKEROOT_PRE_CONFIGURE_HOOKS += HOST_FAKEROOT_BOOTSTRAP_HOOK

# Force capabilities detection off
# For now these are process capabilities (faked) rather than file
# so they're of no real use
HOST_FAKEROOT_CONF_ENV = \
	ac_cv_header_sys_capability_h=no \
	ac_cv_func_capset=no \
	CFLAGS="-pipe -O2 -arch x86_64 -arch i386 -Wno-deprecated-declarations"
		

FAKEROOT_LICENSE = GPL-3.0+
FAKEROOT_LICENSE_FILES = COPYING

$(eval $(host-autotools-package))
