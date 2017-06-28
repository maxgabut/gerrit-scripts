#! /bin/bash

set -e
cd $(dirname $0)

source variables

echo 'Getting gerrit war :'
if [ -f ${GERRIT_WAR_LOCAL_PATH} ]; then
	echo '  file already there, moving on.'
else
	echo '  file absent, fetching it...'
	echo ''
	wget $GERRIT_WAR_URL --output-document $GERRIT_WAR_LOCAL_PATH
	echo '  Done.'
fi
echo ''


echo 'Getting oauth plugin jar :'
if [ -f ${OAUTH_PLUGIN_LOCAL_PATH} ]; then
	echo '  file already there, moving on.'
else
	echo '  file absent, fetching it...'
	echo ''
	wget $OAUTH_PLUGIN_JAR_URL --output-document $OAUTH_PLUGIN_LOCAL_PATH
	echo '  Done.'
fi
echo ''



