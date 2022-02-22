#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/cannonball.git"
REPO_NAME="cannonball"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="cannonball"
ARCHIVE_FILE="${OUT_DIR}/Cannonball (ROMs Required).zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir -p "${SYSTEM_DIR}/res"
cp -r "${REPO_PATH}/roms/roms.txt" "$SYSTEM_DIR"
cp -r "${REPO_PATH}/docs/license.txt" "${SYSTEM_DIR}/res"
cp -r "${REPO_PATH}/res/tilemap.bin" "${SYSTEM_DIR}/res"
cp -r "${REPO_PATH}/res/tilepatch.bin" "${SYSTEM_DIR}/res"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
