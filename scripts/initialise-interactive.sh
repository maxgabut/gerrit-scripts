#!/usr/bin/env bash

set -eu -o pipefail
cd "$(dirname "$0")"

source variables
./copy-resources.sh

echo 'Initializing INTERACTIVELY review site:'
if [ -f "${SITE_INIT_FLAG}" ]; then
	echo '  site already initialized, moving on.'
else
	echo '  not initialized, doing it...'
	echo ''

	java -jar "${GERRIT_WAR_LOCAL_PATH}" init -d "${SITE_PATH}"

	:>"${SITE_INIT_FLAG}"

	echo ''
	echo ' Done.'
fi
echo ''
