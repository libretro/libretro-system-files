#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "${SCRIPT_DIR}/lib/common.sh"

REPO_URL="https://github.com/libretro/scummvm.git"
REPO_NAME="scummvm"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="scummvm"
ARCHIVE_FILE="${OUT_DIR}/ScummVM.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

cd "${REPO_PATH}/backends/platform/libretro/aux-data"
./bundle_aux_data.bash
cp scummvm.zip "$BUILD_DIR"
git checkout -- scummvm.zip

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
unzip scummvm.zip
rm scummvm.zip

cp -r "${REPO_PATH}/COPYRIGHT" "$SYSTEM_DIR"
cp -r "${REPO_PATH}/COPYING"* "$SYSTEM_DIR"
cp -r "${REPO_PATH}/backends/platform/libretro/aux-data/soundfont/README.md" "${SYSTEM_DIR}/Roland_SC-55.txt"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
