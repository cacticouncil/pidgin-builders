#!/bin/sh -ex

cd "${CONVEY_WORKSPACE}"

BUILD_DIR="build-${DISTRO}-${VERSION}-${ARCH}"
meson "${BUILD_DIR}"
ninja -C "${BUILD_DIR}" test
