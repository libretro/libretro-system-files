#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/pcsx2.git"
REPO_NAME="dolphin"
REPO_BRANCH="libretro"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="pcsx2"
ARCHIVE_FILE="${OUT_DIR}/LRPS2.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME" "$REPO_BRANCH"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir -p "$SYSTEM_DIR/resources"
mkdir -p "$SYSTEM_DIR/bios"
cp -r "${REPO_PATH}/bin/resources/shaders" "$SYSTEM_DIR/resources"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
