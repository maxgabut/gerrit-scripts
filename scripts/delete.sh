#! /bin/bash

set -e
cd "$(dirname "$0")"

source variables

if [ -d "${SITE_PATH}" ]; then
	rm -rf "${SITE_PATH}" 
fi
