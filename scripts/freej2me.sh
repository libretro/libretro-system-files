#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/hex007/freej2me.git"
REPO_NAME="freej2me"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="freej2me"
ARCHIVE_FILE="${OUT_DIR}/freej2me.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME"
then
	exit 1
fi

# Requires "ant" to build the library
# https://ant.apache.org/
if ! which ant
then
    echo "freej2me: Missing 'ant'. Install ant to continue."
    exit 1
fi

# Build the library
cd "$REPO_PATH"
ant

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir "$SYSTEM_DIR"
cp "${REPO_PATH}/build/freej2me-lr.jar" "$SYSTEM_DIR"
cp -r "${REPO_PATH}/LICENSE" "$SYSTEM_DIR/freej2me-license"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR/." # Don't have the sub-folder
rm -rf "$SYSTEM_DIR"
