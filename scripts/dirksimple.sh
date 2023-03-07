#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/icculus/DirkSimple.git"
REPO_NAME="DirkSimple"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"
REPO_BRANCH="main"

SYSTEM_DIR="DirkSimple"
ARCHIVE_FILE="${OUT_DIR}/DirkSimple.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME" "$REPO_BRANCH"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir "${SYSTEM_DIR}"
cp -r "${REPO_PATH}/data" "$SYSTEM_DIR"
cp -r "${REPO_PATH}/LICENSE.txt" "${SYSTEM_DIR}

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
