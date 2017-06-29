#! /bin/bash

set -e
cd $(dirname $0)

export OAUTH_GITHUB_CLIENT_ID='_'     # required for variables, obviously no caring here
export OAUTH_GITHUB_CLIENT_SECRET='_' # required for variables, obviously no caring here
source variables

# to be callable in 'set -e'-ed context, this must return true if there is no
# error
[ -d ${SITE_PATH} ] && rm -rf ${SITE_PATH} || true
