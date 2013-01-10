
# include common makefile
$(call inherit-product, device/rockchip/rk3066-common/common.mk)

LOCAL_PATH := device/rockchip/mk808

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_AAPT_PREF_CONFIG := xlarge
PRODUCT_AAPT_configs := xlarge mdpi normal xhdpi hdpi

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.rk30board:root/fstab.rk30board \
    $(LOCAL_PATH)/init.rk30board.rc:root/init.rk30board.rc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.facelock=enable_facelock \
    persist.facelock.detect_cutoff=5000 \
    persist.facelock.recog_cutoff=5000

ADDITIONAL_DEFAULT_PROPERTIES += \
    persist.sys.strictmode.visual=false \
    ro.default.size=100
#    ro.product.usbfactory=rockchip_usb \
#    ro.product.manufacturer=Rockchip \
#    ro.product.model=mk808 \
#   ro.sf.fakerotation=true
#   ro.sf.hwrotation=270

$(call inherit-product-if-exists, vendor/rockchip/mk808/mk808-vendor.mk)
