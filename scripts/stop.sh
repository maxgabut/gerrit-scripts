#! /bin/bash

set -e
cd "$(dirname "$0")"

source variables

"${SITE_PATH}"/bin/gerrit.sh stop

