#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/mame2003-plus-libretro.git"
REPO_NAME="mame2003-plus-libretro"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="mame2003-plus"
ARCHIVE_FILE="${OUT_DIR}/MAME 2003-Plus.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir -p "$SYSTEM_DIR/samples"
cp -r "${REPO_PATH}/metadata/hiscore.dat" "$SYSTEM_DIR"
cp -r "${REPO_PATH}/metadata/cheat.dat" "$SYSTEM_DIR"
cp -r "${REPO_PATH}/metadata/history.dat" "$SYSTEM_DIR"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
