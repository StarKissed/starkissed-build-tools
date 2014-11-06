#!/bin/bash

# Copyright (C) 2011 Twisted Playground

# This script is designed by Twisted Playground for use on MacOSX 10.7 but can be modified for other distributions of Mac and Linux

if cat /etc/issue | grep Ubuntu; then
    BUSYBSPEC=~/android/busybox-android
    TOOLCHAIN_PREFIX=~/android/android-toolchain-eabi/bin/arm-eabi-
    FUSEREPO=~/Dropbox/TwistedServer/ScriptFusion/binaryfiles
    SEDOUTPT='s/CONFIG_SYSROOT=.*$/CONFIG_SYSROOT=\"~\/android\/android-ndk-14\/arch-arm\"/'
else
    BUSYBSPEC=/Volumes/android/busybox-android
    TOOLCHAIN_PREFIX=/Users/TwistedZero/Applications/android-ndk/toolchains/arm-linux-androideabi-4.7/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-
    FUSEREPO=/Users/TwistedZero/Public/Dropbox/TwistedServer/ScriptFusion/binaryfiles
    STARREPO=/Users/TwistedZero/Dropbox/StarKissedMod/res/raw
    DUALREPO=/Users/TwistedZero/Dropbox/NexusDualBoot/res/raw
    SEDOUTPT='s/CONFIG_SYSROOT=.*$/CONFIG_SYSROOT=\"\/Volumes\/android\/android-ndk-14\/arch-arm\"/'
fi
BSYCONFIG=loungekatt_config
CPU_JOB_NUM=8

cd $BUSYBSPEC

sed -i $SEDOUTPT configs/$BSYCONFIG

cp -R configs/$BSYCONFIG .config

make clean -j$CPU_JOB_NUM

# export ARCH=arm
# export CROSS_COMPILE=$TOOLCHAIN_PREFIX
# make

make -j$CPU_JOB_NUM ARCH=arm CROSS_COMPILE=$TOOLCHAIN_PREFIX

file busybox

if [ -e busybox ]; then
    cp -R busybox $FUSEREPO/busybox
    if [ $STARREPO ]; then
        cp -R busybox $STARREPO/busybox
    fi
    if [ $DUALREPO ]; then
        cp -R busybox $DUALREPO/busybox
    fi
fi


