#!/bin/sh -ex

cd "${CONVEY_WORKSPACE}"

TARGET="${TARGET:-unknown}"

BUILD_DIR="build-${TARGET}"

meson -Dsilc=enabled -Ddoc=true "${BUILD_DIR}"
ninja -C "${BUILD_DIR}" test
ninja -C "${BUILD_DIR}" pidgin-pot
ninja -C "${BUILD_DIR}" doc

