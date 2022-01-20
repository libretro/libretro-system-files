#!/bin/bash

set -e

SCRIPT_DIR="$(dirname $(which $0))"
source "${SCRIPT_DIR}/lib/common.sh"

SRC_FILE="${SRC_FILES_DIR}/prboom/prboom.wad"
ARCHIVE_FILE="${OUT_DIR}/PrBoom.zip"

rm -f "$ARCHIVE_FILE"
7z a -mx9 "$ARCHIVE_FILE" "$SRC_FILE"
