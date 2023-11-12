#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/blueMSX-libretro.git"
REPO_NAME="blueMSX-libretro"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

DATABASES_DIR="Databases"
MACHINES_DIR="Machines"
ARCHIVE_FILE="${OUT_DIR}/blueMSX.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$DATABASES_DIR" "$MACHINES_DIR"
cp -r "${REPO_PATH}/system/bluemsx/Databases" "$BUILD_DIR"
cp -r "${REPO_PATH}/system/bluemsx/Machines" "$BUILD_DIR"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$DATABASES_DIR" "$MACHINES_DIR"
rm -rf "$DATABASES_DIR" "$MACHINES_DIR"
