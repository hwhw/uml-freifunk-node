################################################################################
#
# alfred-versioned
#
################################################################################

ALFRED_VERSIONED_VERSION = 2015.0
ALFRED_VERSIONED_SOURCE = alfred-$(ALFRED_VERSIONED_VERSION).tar.gz
ALFRED_VERSIONED_SITE = http://downloads.open-mesh.org/batman/releases/batman-adv-$(ALFRED_VERSIONED_VERSION)
ALFRED_VERSIONED_LICENSE = GPLv2
ALFRED_VERSIONED_DEPENDENCIES = libcap # host-pkgconf

define ALFRED_VERSIONED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) CONFIG_ALFRED_GPSD=n CONFIG_ALFRED_VIS=n BINARY_NAME=alfred14 all
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/vis BINARY_NAME=batadv-vis14 all
endef

define ALFRED_VERSIONED_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) CONFIG_ALFRED_GPSD=n CONFIG_ALFRED_VIS=n BINARY_NAME=alfred14 \
		PREFIX=/usr DESTDIR=$(TARGET_DIR) install
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/vis BINARY_NAME=batadv-vis14 \
		PREFIX=/usr DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))

