TARGET = iphone:10.3:11.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = tstbprefs
tstbprefs_FILES = PBRootListController.m
tstbprefs_INSTALL_PATH = /Library/PreferenceBundles
tstbprefs_FRAMEWORKS = UIKit
tstbprefs_PRIVATE_FRAMEWORKS = Preferences
tstbprefs_LIBRARIES = AppList

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/tstbprefs.plist$(ECHO_END)
