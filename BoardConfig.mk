# inherit from the proprietary version
-include vendor/lge/p880/BoardConfigVendor.mk

# Board nameing
TARGET_NO_RADIOIMAGE := true
TARGET_BOARD_PLATFORM := tegra
TARGET_BOOTLOADER_BOARD_NAME := x3

# Target arch settings
TARGET_NO_BOOTLOADER := true
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a9
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := $(TARGET_CPU_VARIANT)
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_USE_NON_NEON_MEMCPY := true

BOARD_KERNEL_CMDLINE := 
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

# fix this up by examining /proc/mtd on a running device
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1056859750
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13164074762
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_RECOVERY_PRE_COMMAND := "/system/bin/setup-recovery"

# Try to build the kernel
TARGET_KERNEL_SOURCE := kernel/lge/x3
#TARGET_KERNEL_CONFIG := custom_x3_defconfig

BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB = device/lge/p880/rootdir/fstab.x3
RECOVERY_FSTAB_VERSION = 2
TARGET_USERIMAGES_USE_EXT4 := true

TARGET_SPECIFIC_HEADER_PATH := device/lge/p880/include

BOARD_NO_ALLOW_DEQUEUE_CURRENT_BUFFER := true
BOARD_USE_SKIA_LCDTEXT := true
BOARD_EGL_CFG := device/lge/p880/configs/egl.cfg
USE_OPENGL_RENDERER := true
BOARD_EGL_NEEDS_LEGACY_FB := true

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/system/etc/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_P2P := "/system/etc/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_AP := "/system/etc/firmware/fw_bcmdhd_apsta.bin"
BOARD_LEGACY_NL80211_STA_EVENTS := true

TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := device/lge/p880/bluetooth/vnd_bt.txt
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/p880/bluetooth

COMMON_GLOBAL_CFLAGS += -DMR0_AUDIO_BLOB -DMR0_CAMERA_BLOB

# Radio fixes
BOARD_RIL_CLASS := ../../../device/lge/p880/ril/

BOARD_CUSTOM_GRAPHICS := ../../../device/lge/p880/recovery/recovery-gfx.c
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/lge/p880/recovery/recovery-keys.c

BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_BATTERY_DEVICE_NAME := battery

ifeq ($(HAVE_SELINUX),true)

BOARD_SEPOLICY_DIRS := \
    device/lge/p880/selinux

BOARD_SEPOLICY_UNION := \
    file_contexts \
    file.te \
    device.te \
    domain.te

endif

BOARD_HARDWARE_CLASS := device/lge/p880/cmhw/

# TWRP
DEVICE_RESOLUTION := 720x1280
#LANDSCAPE_RESOLUTION := 1280x720

RECOVERY_SDCARD_ON_DATA := true
TW_INCLUDE_JB_CRYPTO := true

TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"

TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTESS := 255

TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
#TARGET_PREBUILT_RECOVERY_KERNEL := device/lge/p880/recovery-kernel

TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/tegra-udc.0/gadget/lun0/file"
TW_INCLUDE_FB2PNG := true

TWHAVE_SELINUX := true
