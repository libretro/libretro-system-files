#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/dolphin.git"
REPO_NAME="dolphin"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="dolphin-emu"
ARCHIVE_FILE="${OUT_DIR}/Dolphin.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir "$SYSTEM_DIR"
cp -r "${REPO_PATH}/Data/Sys" "$SYSTEM_DIR"
cp -r "${REPO_PATH}/LICENSES/GPL-2.0-or-later.txt" "${SYSTEM_DIR}/license.txt"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
