include device/rockchip/rk3066-common/BoardCommonConfig.mk

DEVICE_PACKAGE_OVERLAYS := device/rockchip/mk808/overlay

TARGET_KERNEL_SOURCE := kernel/rockchip
TARGET_KERNEL_CONFIG := rk30_mk808_defconfig

BOARD_HAVE_BLUETOOTH := false

