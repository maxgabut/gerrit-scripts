#!/usr/bin/env bash

set -eu -o pipefail
cd "$(dirname "$0")"

source variables

"${SITE_PATH}"/bin/gerrit.sh start

