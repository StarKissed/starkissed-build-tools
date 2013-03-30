#!/bin/bash

# Copyright (C) 2011 Twisted Playground

# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

if cat /etc/issue | grep Ubuntu; then
    BUSYBSPEC=~/android/busybox-android
    TOOLCHAIN_PREFIX=~/android/android-toolchain-eabi/bin/arm-eabi-
else
    BUSYBSPEC=/Volumes/android/busybox-android
    TOOLCHAIN_PREFIX=/Volumes/android/android-toolchain-eabi/bin/arm-eabi-
fi
BSYCONFIG=loungekatt_config
CPU_JOB_NUM=8

cd $BUSYBSPEC

cp -R configs/$BSYCONFIG .config

make clean -j$CPU_JOB_NUM

# export ARCH=arm
# export CROSS_COMPILE=$TOOLCHAIN_PREFIX
# make

make -j$CPU_JOB_NUM ARCH=arm CROSS_COMPILE=$TOOLCHAIN_PREFIX

file busybox
