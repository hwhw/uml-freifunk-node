################################################################################
#
# batctl-legacy-versioned
#
################################################################################

BATCTL_LEGACY_VERSIONED_VERSION = 2013.4.0
BATCTL_LEGACY_VERSIONED_SOURCE = batctl-$(BATCTL_LEGACY_VERSIONED_VERSION).tar.gz
BATCTL_LEGACY_VERSIONED_SITE = http://downloads.open-mesh.org/batman/releases/batman-adv-$(BATCTL_LEGACY_VERSIONED_VERSION)
BATCTL_LEGACY_VERSIONED_LICENSE = GPLv2
BATCTL_LEGACY_VERSIONED_DEPENDENCIES = libnl host-pkgconf

define BATCTL_LEGACY_VERSIONED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) BINARY_NAME=batctl14 all
endef

define BATCTL_LEGACY_VERSIONED_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		BINARY_NAME=batctl14 PREFIX=/usr DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
