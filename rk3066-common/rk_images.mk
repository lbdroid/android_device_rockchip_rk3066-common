MKKRNLIMG := $(HOST_OUT_EXECUTABLES)/rk_mkkrnlimg
SIMG2IMG := $(HOST_OUT_EXECUTABLES)/simg2img
RK_KERNEL_IMG := $(PRODUCT_OUT)/kernel.img

systemimage_intermediates := $(call intermediates-dir-for,PACKAGING,systemimage)
BUILT_SYSTEMIMAGE := $(systemimage_intermediates)/system.img

$(INSTALLED_BOOTIMAGE_TARGET): $(MKKRNLIMG) $(INTERNAL_BOOTIMAGE_FILES) $(RK_KERNEL_IMG)
	@echo -e ${CL_CYN}"----- Making boot image ------"${CL_RST}
	$(hide) $(MKKRNLIMG) -a $(INSTALLED_RAMDISK_TARGET) $@
	@echo -e ${CL_CYN}"----- Made boot image: $@"${CL_RST}

$(RK_KERNEL_IMG): $(MKKRNLIMG) $(INSTALLED_KERNEL_TARGET)
	@echo -e ${CL_CYN}"----- Making kernel image ------"${CL_RST}
	$(hide) $(MKKRNLIMG) -a $(INSTALLED_KERNEL_TARGET) $@
	@echo -e ${CL_CYN}"----- Made kernel image: $@"${CL_RST}

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKKRNLIMG) $(recovery_ramdisk)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	$(hide) $(MKKRNLIMG) -a $(recovery_ramdisk) $@
	@echo -e ${CL_CYN}"----- Made recovery image: $@"${CL_RST}

rksystemimage: $(SIMG2IMG) $(BUILT_SYSTEMIMAGE)
	@echo -e ${CL_CYN}"----- Making system image ------"${CL_RST}
	$(SIMG2IMG) $(BUILT_SYSTEMIMAGE) $(INSTALLED_SYSTEMIMAGE)
	@echo -e ${CL_CYN}"----- Made system image: $(INSTALLED_SYSTEMIMAGE)"${CL_RST}

.PHONY: bacon rksystemimage
bacon: rksystemimage $(INSTALLED_RECOVERYIMAGE_TARGET) $(INSTALLED_BOOTIMAGE_TARGET)

