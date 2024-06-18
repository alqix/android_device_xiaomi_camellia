#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),camellia)
include $(call all-makefiles-under,$(LOCAL_PATH))

VENDOR_SYMLINKS := \
    $(TARGET_OUT_VENDOR)/lib/hw \
    $(TARGET_OUT_VENDOR)/lib64/hw
    
QPR2_PATCHES := \
    $(TARGET_OUT_VENDOR)/lib64 \
    $(TARGET_OUT_VENDOR)/bin \
    $(TARGET_OUT_VENDOR)/etc \
    $(TARGET_OUT_VENDOR)/etc/init

$(VENDOR_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Making vendor symlinks"
	@mkdir -p $(TARGET_OUT_VENDOR)/lib/hw
	@mkdir -p $(TARGET_OUT_VENDOR)/lib64/hw
	@ln -sf $(TARGET_BOARD_PLATFORM)/libaiselector.so $(TARGET_OUT_VENDOR)/lib/libaiselector.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libdpframework.so $(TARGET_OUT_VENDOR)/lib/libdpframework.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libmtk_drvb.so $(TARGET_OUT_VENDOR)/lib/libmtk_drvb.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libpq_prot.so $(TARGET_OUT_VENDOR)/lib/libpq_prot.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libaiselector.so $(TARGET_OUT_VENDOR)/lib64/libaiselector.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libdpframework.so $(TARGET_OUT_VENDOR)/lib64/libdpframework.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libmtk_drvb.so $(TARGET_OUT_VENDOR)/lib64/libmtk_drvb.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libpq_prot.so $(TARGET_OUT_VENDOR)/lib64/libpq_prot.so
	@ln -sf $(TARGET_BOARD_PLATFORM)/libnir_neon_driver.so $(TARGET_OUT_VENDOR)/lib64/libnir_neon_driver.so
	$(hide) touch $@
	
$(QPR2_PATCHES): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Installing QPR2 Patches"
	@mkdir -p $(TARGET_OUT_VENDOR)/lib64
	@mdkir -p $(TARGET_OUT_VENDOR)/bin
	@mkdir -p $(TARGET_OUT_VENDOR)/etc
	@mkdir -p $(TARGET_OUT_VENDOR)/etc/init
	@rm -rf $(TARGET_OUT_SYSTEM)/lib64/libbpf_android.so
	@rm -rf $(TARGET_OUT_SYSTEM)/lib64/libbpf_bcc.so
	@rm -rf $(TARGET_OUT_SYSTEM)/lib64/libbpf_minimal.so
	@rm -rf $(TARGET_OUT_SYSTEM)/bin/bpfloader
	@rm -rf $(TARGET_OUT_SYSTEM)/etc/init/bpfloader.rc
	@rm -rf $(TARGET_OUT_SYSTEM)/etc/init/netbpfload.rc
	@cp -r $(DEVICE_PATH)/libs/* $(TARGET_OUT_SYSTEM)/
	$(hide) touch $@

ALL_DEFAULT_INSTALLED_MODULES += $(VENDOR_SYMLINKS) $(QPR2_PATCHES)

endif
