#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "${SCRIPT_DIR}/lib/common.sh"

REPO_URL="https://github.com/libretro/FBNeo.git"
REPO_NAME="FBNeo"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="fbneo"
ARCHIVE_FILE="${OUT_DIR}/FinalBurn Neo (hiscore).zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir "$SYSTEM_DIR"
cp -r "${REPO_PATH}/metadata/hiscore.dat" "$SYSTEM_DIR"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
