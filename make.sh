#!/bin/bash

ROOT_DIR="$(dirname $(which $0))"
SCRIPTS_DIR="${ROOT_DIR}/scripts"
OUT_DIR="${ROOT_DIR}/out"

cd "$SCRIPTS_DIR"

for BUILD_SCRIPT in *.sh
do
	/bin/bash ./"$BUILD_SCRIPT"
	if [[ $? -ne 0 ]]
	then
	  echo "script failed: $BUILD_SCRIPT"
	  return 1
	fi
done

cd "$OUT_DIR"
ls *.* > .index
