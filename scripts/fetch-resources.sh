#! /bin/bash

set -e
cd "$(dirname "$0")"

source variables
source checks

function download_file() {
	[ $# -eq 0 ] && fail_for_missing_arg || source_url=${1}; shift;
	[ $# -eq 0 ] && fail_for_missing_arg || dest_path=${1}; shift;

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

download_file "${GERRIT_WAR_URL}" "${GERRIT_WAR_LOCAL_PATH}"
download_file "${OAUTH_PLUGIN_JAR_URL}" "${OAUTH_PLUGIN_LOCAL_PATH}"

