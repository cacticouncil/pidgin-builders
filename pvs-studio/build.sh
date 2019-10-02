#!/bin/sh -ex
# Copyright (C) 2015-2019  Gary Kramlich <grim@reaperworld.com>
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
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

cd ${CONVEY_WORKSPACE}

BUILD_DIR="build-pvs-studio"
PLOG_ARGS="--excludedCodes V011,V1042"

# don't leak our secrets via `set -x`
set +x
if [ -z "${PVS_STUDIO_USERNAME}" -o -z "${PVS_STUDIO_KEY}" ] ; then
	echo "Both PVS_STUDIO_USERNAME and PVS_STUDIO_KEY must be provided" >&2
	exit 1
fi
set -x

# don't echo commands as we're stashing secrets
set +x
echo "${PVS_STUDIO_USERNAME}" > /license
echo "${PVS_STUDIO_KEY}" >> /license
set -x

meson ${BUILD_DIR}
cd ${BUILD_DIR}

echo "running ninja because we don't have a way to just generate the built source files" >&2
ninja

echo "creating compile_commands.json"
ninja -t compdb

# run the analyzer
pvs-studio-analyzer analyze -l /license -o pvs-studio.log

# convert the output to html
plog-converter -a GA:1,2 -t fullhtml -o pvs-studio -p ${HG_REMOTE} -v ${HG_COMMIT} ${PLOG_ARGS} pvs-studio.log
cp -a pvs-studio ${CONVEY_WORKSPACE}

# run the converter to determine if we found issues
plog-converter -a GA:1,2 -t tasklist ${PLOG_ARGS} -o ${CONVEY_WORKSPACE}/pvs-studio/tasklist.txt pvs-studio.log
ERRORS=$(wc -l ${CONVEY_WORKSPACE}/pvs-studio/tasklist.txt | awk '{print $1}')
# the tasklist output has a stock line at the top, which we ignore by checking
# if we have more than one line in the file
if [ "${ERRORS}" -gt 1 ] ; then
	exit 1
fi

exit 0

