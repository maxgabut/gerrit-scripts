#!/usr/bin/env bash

set -eu -o pipefail

source variables
./fetch-resources.sh

echo 'Copying resources:'
if [ -f "${SITE_RESOURCES_COPIED_FLAG}" ]; then
	echo '  resource already copies, moving on.'
else
	echo '  not copied yet, doing it...'

	./delete.sh

	mkdir -p "${SITE_PATH}"
	mkdir -p "${PLUGIN_PATH}"

	cp "${OAUTH_PLUGIN_LOCAL_PATH}" "${PLUGIN_PATH}"/

	touch "${SITE_RESOURCES_COPIED_FLAG}"

	echo ''
	echo '  Done.'
fi
echo ''
