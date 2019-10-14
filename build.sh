#!/bin/bash

echo "--- Installing dependencies"

apt update
apt install -y \
    libudev-dev \
    libinput-dev \
    libts-dev \
    libxcb-xinerama0-dev \
    libxcb-xinerama0 \
    speech-dispatcher \
    libudev-dev \
    libsdl2-dev \
    libgstreamer1.0-0 \
    gstreamer1.0-plugins-base \
    libgstreamer-plugins-base1.0-dev

apt install -y \
    qt5-default \
    qtbase5-private-dev \
    qtbase5-dev \
    qtbase5-dev-tools \
    libqt5texttospeech5-dev \
    libqt5svg5-dev \
    qtmultimedia5-dev \
    libqt5serialbus5-dev \
    libqt5charts5-dev \
    libqt5serialport5-dev \
    qtdeclarative5-private-dev \
    qttools5-private-dev \
    qtquickcontrols2-5-dev \
    libssl-dev \
    libgstreamer-plugins-base1.0-dev

echo "--- Building qtlocation"

mkdir -p /build_dep
cd /build_dep
git clone https://github.com/qt/qtlocation.git
cd qtlocation
git checkout v5.11.3
mkdir build
cd build/
qmake ../qtlocation.pro
make -j2
make install

echo "--- Stubbing out texttospeech"

mkdir -p /usr/lib/arm-linux-gnueabihf/qt5/plugins/texttospeech

echo "--- Building QGroundControl"

mkdir -p /build/shadow_build_dir
cd /build/shadow_build_dir

qmake -r ../qgroundcontrol.pro CONFIG+=release
make -j2

