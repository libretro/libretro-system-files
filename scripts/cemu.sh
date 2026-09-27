#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/cemu-project/cemu_graphic_packs.git"
REPO_NAME="cemu_graphic_packs"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="Cemu"
PACKS_DIR="${SYSTEM_DIR}/graphicPacks/downloadedGraphicPacks"
ARCHIVE_FILE="${OUT_DIR}/Cemu.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir -p "$PACKS_DIR"
# The same folders, merged the same way, as the release zips standalone Cemu
# downloads into graphicPacks/downloadedGraphicPacks
for PACK_GROUP in Enhancements Resolutions Mods Workarounds src
do
	cp -r "${REPO_PATH}/${PACK_GROUP}/"* "$PACKS_DIR"
done
cp "${REPO_PATH}/LICENSE.md" "${PACKS_DIR}/LICENSE.md"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
