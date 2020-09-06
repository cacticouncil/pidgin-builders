#!/bin/sh -ex
# Copyright (C) 2015-2020  Gary Kramlich <grim@reaperworld.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

TARGET="${TARGET:-unknown}"
RECIPE="${RECIPE:-pidgin3}"
RECIPE_PATH="${RECIPE_PATH:-packaging/${RECIPE}.AppImageBuilder.yml}"

BUILD_NUMBER="${BUILD_NUMBER:-0}"
COMMIT="${HG_COMMIT_SHORT:-unknown-rev}"
VERSION="${VERSION:-${BUILD_NUMBER}~${COMMIT_SHORT}}"

cd "${HOME}"

meson ${CONFIGURE_ARGS} --prefix=/usr --buildtype=release "${CONVEY_WORKSPACE}" build
DESTDIR=$(pwd)/AppDir ninja -C build install
appimage-builder --skip-tests --recipe "${CONVEY_WORKSPACE}/${RECIPE_PATH}"

mkdir -p "${CONVEY_WORKSPACE}/${TARGET}"
mv *.AppImage "${CONVEY_WORKSPACE}/${TARGET}/"

