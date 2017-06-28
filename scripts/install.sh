#! /bin/bash

set -e
cd $(dirname $0)

source variables

./fetch-resources.sh

echo 'Initializing review site' :
if [ -f ${SITE_INIT_FLAG} ]; then
	echo '  site already initialized, moving on.'
else
	echo '  not initialized, doing it...'
	echo ''

	./delete.sh
	mkdir -p ${SITE_PATH}
	mkdir -p ${PLUGIN_PATH}
	touch ${SITE_INIT_FLAG}

	cp ${OAUTH_PLUGIN_LOCAL_PATH} ${PLUGIN_PATH}/

	java -jar ${GERRIT_WAR_LOCAL_PATH} init \
		--batch \
		--no-auto-start \
		-d ${SITE_PATH}

	echo ''
	echo ' Done.'
fi
echo ''
