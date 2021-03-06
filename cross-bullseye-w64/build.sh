#!/bin/sh -ex

cd "${CONVEY_WORKSPACE}"

TARGET="${TARGET:-unknown}"

BUILD_DIR="build-${TARGET}"

#meson build-win64 --cross-file win32_cross.txt --prefix=/mingw64/ -Dconsoleui=false -Dintrospection=false -Dvv=disabled  -Dlibdir=lib
#export PKG_CONFIG_PATH=/windows/mingw64/lib/pkgconfig
#export PKG_CONFIG_SYSROOT_DIR=/pidgin-source/

#meson "${BUILD_DIR}"
#ninja -C "${BUILD_DIR}" test
#ninja -C "${BUILD_DIR}" $(ninja -C "${BUILD_DIR}" -t targets | cut -d: -f1 | grep -E '[a-z]+-doc$')

while true; do sleep 1000; done
