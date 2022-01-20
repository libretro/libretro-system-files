#!/bin/bash

LIB_DIR="$(dirname $(which $0))"
SRC_FILES_DIR="${LIB_DIR}/../src_files"
SRC_REPOS_DIR="${LIB_DIR}/../src_repos"
BUILD_DIR="${LIB_DIR}/../build"
OUT_DIR="${LIB_DIR}/../out"

# Performs a shallow clone of specified github repo,
# updating local clone if it already exists
#    $1: repo url
#    $2: local repo directory name
function update_src_repo() 
{
	local repo_url="$1"
	local repo_name="$2"
	local repo_path="${SRC_REPOS_DIR}/${repo_name}"

	# Sanity check
	if [[ -z "$repo_url" || -z "$repo_name" ]]
	then
		echo "update_src_repo: invalid repository url/name..."
		exit 1
	fi

	if [[ -d "$repo_path" ]]
	then
		# If path exists, update local repository
		cd "$repo_path"
		if ! git fetch --depth 1 && git reset --hard origin/master && git clean -dfx
		then
			echo "update_src_repo: failed to update repository $repo_name..."
			exit 2
		fi
	else
		# Otherwise clone a new copy
		if ! git clone -b master "$repo_url" --depth=1 "$repo_path"
		then
			echo "update_src_repo: failed to clone repository $repo_name..."
			exit 3
		fi
	fi
}
