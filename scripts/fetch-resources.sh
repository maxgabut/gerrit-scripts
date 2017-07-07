#!/usr/bin/env bash

set -eu -o pipefail
cd "$(dirname "$0")"

source variables
source checks

function download_file() {
	[ $# -eq 0 ] && fail_for_missing_arg; local source_url=${1}; shift;
	[ $# -eq 0 ] && fail_for_missing_arg; local dest_path=${1};  shift;

	echo "Downloading ${source_url}:"
	if [ -f "${dest_path}" ]; then
		echo ' file already there, moving on.'
	else
		echo ''
		wget "${source_url}" --output-document "${dest_path}"
		echo '  Done.'
	fi

	echo ''
}

function clone_git_repo() {
	[ $# -eq 0 ] && fail_for_missing_arg || repo_url=${1}; shift;
	[ $# -eq 0 ] && fail_for_missing_arg || commit_ish=${1}; shift;
	[ $# -eq 0 ] && fail_for_midding_arg || local_copy_path=${1}; shift;

	echo "Cloning ${repo_url} :"
	if [ -d "${local_copy_path}" ]; then
		echo '  repo already there, moving on.'
	else
		echo '  repo absent, fetching it...'
		echo ''
		git clone "${repo_url}" "${local_copy_path}"
		pushd "${local_copy_path}"
			git checkout "${commit_ish}"
		popd
		echo '  Done.'
	fi
	echo ''
}

function build_maven_project() {
	[ $# -eq 0 ] && fail_for_missing_arg || project_path=${1}; shift;

	echo "Building ${project_path} :"
	if [ -d "${project_path}"/target ]; then
		echo '  already built, moving on.'
	else
		pushd "${project_path}"
			mvn clean install
		popd
	fi
}

download_file "${GERRIT_WAR_URL}" "${GERRIT_WAR_LOCAL_PATH}"
download_file "${OAUTH_PLUGIN_JAR_URL}" "${OAUTH_PLUGIN_LOCAL_PATH}"

clone_git_repo \
	"${GITHUB_PLUGIN_REPO_URL}" \
	"origin/stable-${GITHUB_PLUGIN_VERSION}" \
	"${GITHUB_PLUGIN_LOCAL_COPY}"

build_maven_project "${GITHUB_PLUGIN_OAUTH_PROJECT}"
build_maven_project "${GITHUB_PLUGIN_PLUGIN_PROJECT}"

