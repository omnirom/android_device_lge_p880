#
# Copyright (C) 2013 The OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Get the long list of APNs
PRODUCT_COPY_FILES := vendor/omni/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# Inherit from the common AOSP product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

TARGET_BOOTANIMATION_NAME := vertical-720x1280

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/lge/p880/p880.mk)

# Release name and versioning
PRODUCT_RELEASE_NAME := Optimus 4X HD
#PRODUCT_VERSION_DEVICE_SPECIFIC :=

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := p880
PRODUCT_NAME := omni_p880
PRODUCT_BRAND := LG
PRODUCT_MODEL := LG-P880
PRODUCT_MANUFACTURER := LGE

# Kernel inline build
TARGET_KERNEL_CONFIG := omni_x3_defconfig
TARGET_VARIANT_CONFIG := omni_x3_defconfig
TARGET_SELINUX_CONFIG := omni_x3_defconfig

# Enable OmniTorch
PRODUCT_PACKAGES += OmniTorch

$(call inherit-product-if-exists, vendor/lge/p880/p880-vendor.mk)
