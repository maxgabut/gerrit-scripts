#! /bin/bash

set -e
cd $(dirname $0)

source variables

tail -f ${SITE_PATH}/logs/error_log \
	-f ${SITE_PATH}/logs/httpd_log \
	-f ${SITE_PATH}/logs/sshd_log

