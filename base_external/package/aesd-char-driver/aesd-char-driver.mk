
##############################################################
#
# AESD-CHAR-Driver
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_CHAR_DRIVER_VERSION = 3f27a0796e5d5a7f07b78fd0d5aeedf54e629976
AESD_CHAR_DRIVER_SITE =  git@github.com:cu-ecen-aeld/assignments-3-and-later-mrjaiswa.git
AESD_CHAR_DRIVER_SITE_METHOD = git
AESD_CHAR_DRIVER_GIT_SUBMODULES = YES
AESD_CHAR_DRIVER_MODULE_SUBDIRS = aesd-char-driver



$(eval $(kernel-module))
$(eval $(generic-package))

