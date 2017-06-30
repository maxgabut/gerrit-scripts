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


echo 'Getting github integration plugin :'
if [ -d ${GITHUB_PLUGIN_LOCAL_COPY} ]; then
	echo '  file already there, moving on.'
else
	echo '  file absent, getting it...'
	echo ''
	git clone ${GITHUB_PLUGIN_REPO_URL} ${GITHUB_PLUGIN_LOCAL_COPY}
	pushd ${GITHUB_PLUGIN_LOCAL_COPY}
	  # stable... isn't a stable the place one put horses ?
		git checkout origin/stable-${GITHUB_PLUGIN_VERSION}
		mvn clean install
	popd
	echo '  Done.'
fi
echo ''


