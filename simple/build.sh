#!/bin/sh -ex

cd "${CONVEY_WORKSPACE}"

TARGET="${TARGET:-unknown}"

BUILD_DIR="build-${TARGET}"

meson "${BUILD_DIR}"
ninja -C "${BUILD_DIR}" test
ninja -C "${BUILD_DIR}" $(ninja -C "${BUILD_DIR}" -t targets | cut -d: -f1 | grep -E '[a-z]+-doc$')

