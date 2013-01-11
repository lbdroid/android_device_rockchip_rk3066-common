#
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk

-include device/rockchip/rk3066-common/BoardCommonConfig.mk

USE_CAMERA_STUB := false

PRODUCT_MODEL := Rockchip MK808
PRODUCT_MANUFACTURER := Rockchip

PRODUCT_PROPERTY_OVERRIDES += \
	ro.carrier=wifi-only

# Kernel
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := console=ttyFIQ0 androidboot.console=ttyFIQ0 init=/init initrd=0x62000000,0x00120000 mtdparts=rk29xxnand:0x00002000@0x00002000(misc),0x00004000@0x00004000(kernel),0x00008000@0x00008000(boot),0x00008000@0x00010000(recovery),0x00040000@0x00018000(cache),0x00002000@0x00058000(kpanic),0x00100000@0x0005A000(system),-@0x0015A000(userdata) bootver=2012-08-29
TARGET_KERNEL_CONFIG := rk30_mk808_defconfig

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 419430400
BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912
BOARD_FLASH_BLOCK_SIZE := 16384

BOARD_HAVE_BLUETOOTH := false

