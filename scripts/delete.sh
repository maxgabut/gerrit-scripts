#! /bin/bash

set -e
cd $(dirname $0)

source variables

# to be callable in 'set -e'-ed context, this must return true if there is no
# error
[ -d ${SITE_PATH} ] && rm -r ${SITE_PATH} || true
