#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/libretro/ecwolf.git"
REPO_NAME="ecwolf"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

PK3_FILE="${BUILD_DIR}/ecwolf.pk3"
ARCHIVE_FILE="${OUT_DIR}/ECWolf.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

rm -f "$PK3_FILE"
7z a -mx9 -tzip "$PK3_FILE" "${REPO_PATH}/wadsrc/static/"*

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$PK3_FILE"
rm -f "$PK3_FILE"
