
##############################################################
#
# AESD-CHAR-Driver
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_CHAR_DRIVER_VERSION = 3d5aec99514e3db7a139ba699ed5011d86e735b3
AESD_CHAR_DRIVER_SITE =  git@github.com:cu-ecen-aeld/assignments-3-and-later-mrjaiswa.git
AESD_CHAR_DRIVER_SITE_METHOD = git
AESD_CHAR_DRIVER_GIT_SUBMODULES = YES
AESD_CHAR_DRIVER_MODULE_SUBDIRS = aesd-char-driver
define AESD_CHARDRIVER_INSTALL_TARGET_CMDS

	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin

	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment8/drivertest.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment8/assignment-test.sh $(TARGET_DIR)/usr/bin
$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment8/sockettest.sh $(TARGET_DIR)/usr/bin
endef
$(eval $(kernel-module))
$(eval $(generic-package))

