RK_UPDATE_PATH := $(PRODUCT_OUT)/rkupdate
INSTALLED_BOOTIMAGE_TARGET := $(RK_UPDATE_PATH)/boot.img
INSTALLED_RECOVERYIMAGE_TARGET := $(RK_UPDATE_PATH)/recovery.img
INSTALLED_KERNELIMAGE_TARGET := $(RK_UPDATE_PATH)/kernel.img
INSTALLED_SYSTEMIMAGE_TARGET := $(RK_UPDATE_PATH)/system.img
MKKRNLIMG := $(HOST_OUT_EXECUTABLES)/rk_mkkrnlimg

$(INSTALLED_BOOTIMAGE_TARGET) : $(MKKRNLIMG) $(INSTALLED_RAMDISK_TARGET)
	@echo -e ${CL_CYN}"----- Making boot image ------"${CL_RST}
	mkdir -p $(RK_UPDATE_PATH)
	$(hide) $(MKKRNLIMG) -a $(INSTALLED_RAMDISK_TARGET) $@
$(INSTALLED_RECOVERYIMAGE_TARGET) : $(MKKRNLIMG) $(recovery_ramdisk)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	mkdir -p $(RK_UPDATE_PATH)
	$(hide) $(MKKRNLIMG) -a $(recovery_ramdisk) $@
	@echo -e ${CL_CYN}"----- Making kernel image ------"${CL_RST}
	mkdir -p $(RK_UPDATE_PATH)
	$(hide) $(MKKRNLIMG) -a $(PRODUCT_OUT)/kernel $(INSTALLED_KERNELIMAGE_TARGET)

$(RK_UPDATE_PATH)/system.img: $(RK_UPDATE_PATH)/system.img $(FULL_SYSTEMIMAGE_DEPS) $(INSTALLED_FILES_FILE)
	@echo -e ${CL_CYN}"----- Making rk_system image ------"${CL_RST}
	$(HOST_OUT_EXECUTABLES)/simg2img $(BUILT_SYSTEMIMAGE) $@
$(RK_UPDATE_PATH)/update.img: $(INSTALLED_BOOTIMAGE_TARGET) $(INSTALLED_RECOVERYIMAGE_TARGET) $(RK_UPDATE_PATH)/system.img
	cp device/rockchip/rk3066-common/package/* $(RK_UPDATE_PATH)
	cd $(RK_UPDATE_PATH) && $(HOST_OUT_EXECUTABLES)/rk_afptool -pack $(RK_UPDATE_PATH) update.img
$(RK_UPDATE_PATH)/flash.img: $(RK_UPDATE_PATH)/update.img
	cd $(RK_UPDATE_PATH) && $(HOST_OUT_EXECUTABLES)/rk_img_maker "RK30xxLoader(L)_V1.16.bin" update.img flash.img
.PHONY: rk_systemimage rk_updateimage rk_flashimage rk_clean
rk_systemimage: $(RK_UPDATE_PATH)/system.img

rk_updateimage: $(RK_UPDATE_PATH)/update.img

rk_flashimage: $(RK_UPDATE_PATH)/flash.img
rk_clean:
	rm $(RK_UPDATE_PATH) -rf
