#!/bin/bash

ROOT_DIR="$(dirname $(which $0))"
SCRIPTS_DIR="$(realpath "${ROOT_DIR}/scripts")"
OUT_DIR="$(realpath "${ROOT_DIR}/out")"

cd "$SCRIPTS_DIR"

for BUILD_SCRIPT in *.sh
do
	/bin/bash ./"$BUILD_SCRIPT"
	if [[ $? -ne 0 ]]
	then
	  echo "script failed: $BUILD_SCRIPT"
	  exit 1
	fi
done

cd "$OUT_DIR"
ls *.* > .index
