################################################################################
#
# VBoxGuestAddtions (linux drivers)
#
################################################################################

VBOXGUEST_VERSION = 5.2.6
#VBOXGUEST_VERSION = 5.2.8
VBOXGUEST_SOURCE = VBoxGuestAdditions_$(VBOXGUEST_VERSION).iso
VBOXGUEST_SITE = http://download.virtualbox.org/virtualbox/$(VBOXGUEST_VERSION)
VBOXGUEST_MOUNT = /Volumes/VBox_GAs_$(VBOXGUEST_VERSION)
VBOXGUEST_LINUXRUN = $(VBOXGUEST_MOUNT)/VBoxLinuxAdditions.run
VBOXGUEST_MODS_SRCDIR = $(VBOXGUEST_SRCDIR)/src/vboxguest-$(VBOXGUEST_VERSION)

ifeq ($(BR2_i386),y)
VBOXGUEST_LINUX_ARCHIVE = VBoxGuestAdditions-x86.tar.bz2
VBOXGUEST_MODS_BUILD_TARGET_ARCH="x86"
endif

ifeq ($(BR2_x86_64),y)
VBOXGUEST_LINUX_ARCHIVE = VBoxGuestAdditions-amd64.tar.bz2
VBOXGUEST_MODS_BUILD_TARGET_ARCH="x86_64"
endif

VBOXGUEST_MAKE_OPTS = BUILD_TARGET_ARCH="$(VBOXGUEST_MODS_BUILD_TARGET_ARCH)" KERN_VER="$(LINUX_VERSION)" KERN_DIR="$(LINUX_DIR)" INSTALL_MOD_PATH="$(TARGET_DIR)/usr"  $(MAKE_OPTS)

define VBOXGUEST_EXTRACT_CMDS
	hdiutil mount $(DL_DIR)/$(VBOXGUEST_SOURCE)
	$(VBOXGUEST_LINUXRUN) --noexec --target $(@D)/.tmp
	tar -xf $(@D)/.tmp/$(VBOXGUEST_LINUX_ARCHIVE) -C $(@D)
	rm -Rf $(@D)/.tmp
	hdiutil unmount $(VBOXGUEST_MOUNT)
endef

#CPPFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os " CXXFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os " LDFLAGS="" FCFLAGS=" -Os " FFLAGS=" -Os "

define VBOXGUEST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) $(VBOXGUEST_MAKE_OPTS) -C $(VBOXGUEST_MODS_SRCDIR)
endef

define VBOXGUEST_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) $(VBOXGUEST_MAKE_OPTS) -C $(VBOXGUEST_MODS_SRCDIR) install
	mkdir -p $(TARGET_DIR)/etc/depmod.d
	echo "override vboxguest * misc" > $(TARGET_DIR)/etc/depmod.d/vboxvideo-upstream.conf
	echo "override vboxsf * misc" >> $(TARGET_DIR)/etc/depmod.d/vboxvideo-upstream.conf
	echo "override vboxvideo * misc" >> $(TARGET_DIR)/etc/depmod.d/vboxvideo-upstream.conf
endef

VBOXGUEST_LICENSE = GPL-2.0
VBOXGUEST_LICENSE_FILES = COPYING

$(eval $(generic-package))
