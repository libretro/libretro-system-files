#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/scummvm.git"
REPO_NAME="scummvm"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"
REPO_BRANCH="master"

SYSTEM_DIR="scummvm"
ARCHIVE_FILE="${OUT_DIR}/ScummVM.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME" "$REPO_BRANCH"
then
	exit 1
fi

cd "${REPO_PATH}"
make datafiles -C backends/platform/libretro
cp scummvm.zip "$BUILD_DIR"

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
unzip scummvm.zip
rm scummvm.zip

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
