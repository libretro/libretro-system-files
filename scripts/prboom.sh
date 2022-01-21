#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/libretro-prboom.git"
REPO_NAME="libretro-prboom"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SRC_FILE="${REPO_PATH}/prboom.wad"
ARCHIVE_FILE="${OUT_DIR}/PrBoom.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SRC_FILE"
