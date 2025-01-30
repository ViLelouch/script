#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/mojito

# Initialize ROM manifest
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove source vendor/lineage 
rm -rf vendor/lineage

# cloning device tree
git clone https://github.com/ViLelouch/android_device_xiaomi_mojito.git --depth 1 -b ros device/xiaomi/mojito

# cloning kernel tree
git clone https://github.com/Kou-Yeager/kernel_xiaomi_mojito.git --depth 1 -b BORE+UCLAMP kernel/xiaomi/mojito

# cloning vendor tree
git clone https://github.com/Kou-Yeager/android_vendor_xiaomi_mojito.git --depth 1 -b lineage-22 vendor/xiaomi/mojito

# add vendor/lineage
git clone https://github.com/ViLelouch/android_vendor_lineage.git --depth 1 -b fourteen vendor/lineage

# Set up th build environment
. build/envsetup.sh

# Choose the target device
riseup mojito userdebug

#  full building
rise b
