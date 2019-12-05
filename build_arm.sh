#!/bin/bash

# Build and package QGroundControl for arm

echo "Creating ${SHADOW_BUILD_DIR}"

mkdir -p ${SHADOW_BUILD_DIR}
cd ${SHADOW_BUILD_DIR}

echo "Configuring project"

if [ "${ARCH}" = "arm64" ]; then
    qmake -r /build/qgroundcontrol.pro CONFIG+=installer
else
    qmake -r /build/qgroundcontrol.pro CONFIG+=installer DEFINES+=__rasp_pi2__
fi

echo "Building project"

make -j2

echo "Preparing deployment"

cd /build

if [ "${ARCH}" = "arm64" ]; then
    ./deploy/create_linux_appimage_raspbian.sh /build ${SHADOW_BUILD_DIR}/release ${SHADOW_BUILD_DIR}/release/package;
else 
    ./deploy/create_linux_appimage_debian64.sh /build ${SHADOW_BUILD_DIR}/release ${SHADOW_BUILD_DIR}/release/package;
fi
