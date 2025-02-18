#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/mojito

# Initialize ROM manifest
repo init -u https://github.com/ArrowOS-T/android_manifest.git -b arrow-13.1_ext

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove vendor/arrow
rm -rf vendor/arrow

# cloning device tree
git clone https://github.com/ViLelouch/android_device_xiaomi_mojito.git --depth 1 -b test device/xiaomi/mojito

# cloning kernel tree
git clone https://github.com/daralys/android_kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

# cloning vendor tree
git clone https://github.com/ViLelouch/android_vendor_xiaomi_mojito.git --depth 1 -b 13 vendor/xiaomi/mojito

# add modify
git clone https://github.com/ViLelouch/android_vendor_arrow.git --depth 1 -b arrow-13.1_ext vendor/arrow

# Set up th build environment
. build/envsetup.sh

# Choose the target device
lunch arrow_mojito-userdebug

# Build the ROM (use mka bacon for a full build)
m bacon
