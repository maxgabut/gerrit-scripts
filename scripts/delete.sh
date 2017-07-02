#!/usr/bin/env bash

set -eu -o pipefail
cd "$(dirname "$0")"

source variables

if [ -d "${SITE_PATH}" ]; then
	rm -rf "${SITE_PATH}" 
fi
