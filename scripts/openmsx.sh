#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/WizzardSK/openmsx-libretro.git"
REPO_NAME="openmsx-libretro"
REPO_BRANCH="libretro"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="openmsx"
ARCHIVE_FILE="${OUT_DIR}/openMSX.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME" "$REPO_BRANCH"
then
	exit 1
fi

cd "$BUILD_DIR"

# What the core reads from <system>/openmsx/share: openMSX's share folder
# (machines, extensions, scripts, software database) with C-BIOS added as an
# install puts it, so games start on the C-BIOS machines without other ROMs
rm -rf "$SYSTEM_DIR"
mkdir -p "${SYSTEM_DIR}/share/systemroms/cbios-old"
cp -r "${REPO_PATH}/share/"* "${SYSTEM_DIR}/share"
cp -r "${REPO_PATH}/Contrib/cbios/"* "${SYSTEM_DIR}/share/machines"
cp -r "${REPO_PATH}/Contrib/cbios-old/"* "${SYSTEM_DIR}/share/systemroms/cbios-old"
cp "${REPO_PATH}/Contrib/README.cbios" "${SYSTEM_DIR}/share/cbios.txt"
cp "${REPO_PATH}/doc/GPL.txt" "${SYSTEM_DIR}/GPL.txt"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
