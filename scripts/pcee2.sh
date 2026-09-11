#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "$(realpath "${SCRIPT_DIR}/lib/common.sh")"

REPO_URL="https://github.com/PCSX2/pcsx2_patches.git"
REPO_NAME="pcsx2_patches"
REPO_BRANCH="main"
REPO_PATH="${SRC_REPOS_DIR}/${REPO_NAME}"

SYSTEM_DIR="pcsx2"
ARCHIVE_FILE="${OUT_DIR}/PCEE2.zip"

if ! update_src_repo "$REPO_URL" "$REPO_NAME" "$REPO_BRANCH"
then
	exit 1
fi

cd "$BUILD_DIR"

rm -rf "$SYSTEM_DIR"
mkdir -p "$SYSTEM_DIR/resources"

# The core reads the game patches out of a zip rather than a directory, so this
# one holds an archive inside the archive. It is packed the way pcsx2_patches
# packs its own release, from the .pnach sources rather than by fetching that
# release, so what ships here is always the current set.
PATCHES_FILE="$(realpath "${SYSTEM_DIR}/resources")/patches.zip"
(cd "$REPO_PATH" && 7z a -mx9 -r "$PATCHES_FILE" ./patches/*)

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SYSTEM_DIR"
rm -rf "$SYSTEM_DIR"
