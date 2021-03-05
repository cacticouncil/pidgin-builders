#!/bin/sh -ex
#ENV MINGW_DISTRO=mingw-w64-x86_64 PREFIX=/mingw64

cd "${CONVEY_WORKSPACE}"

TARGET="${TARGET:-unknown}"

BUILD_DIR="build-${TARGET}"

#meson "${BUILD_DIR}"
#ninja -C "${BUILD_DIR}" test
#ninja -C "${BUILD_DIR}" $(ninja -C "${BUILD_DIR}" -t targets | cut -d: -f1 | grep -E '[a-z]+-doc$')

while true; do sleep 1000; done
