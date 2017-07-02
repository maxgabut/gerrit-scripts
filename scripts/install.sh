#!/usr/bin/env bash

set -eu -o pipefail
cd "$(dirname "$0")"

source variables

./initialise.sh

set_in_gerrit_config() {
	git config -f "${SITE_PATH}/etc/gerrit.config" "$@"
}

set_in_secure_config() {
	git config -f "${SITE_PATH}/etc/secure.config" "$@"
}

echo 'Setting up configuration' :
	set_in_gerrit_config gerrit.canonicalWebUrl "${GERRIT_CANONIAL_WEB_URL}"
	# authentication oauth
	set_in_gerrit_config auth.type OAUTH
	set_in_secure_config auth.gitBasicAuthPolicy HTTP
	# authentication with github
	set_in_gerrit_config plugin.gerrit-oauth-provider-github-oauth.client-id "${OAUTH_GITHUB_CLIENT_ID}"
	set_in_secure_config plugin.gerrit-oauth-provider-github-oauth.client-secret "${OAUTH_GITHUB_CLIENT_SECRET}"
	# authentication with google
	set_in_gerrit_config plugin.gerrit-oauth-provider-google-oauth.client-id "${OAUTH_GOOGLE_CLIENT_ID}"
	set_in_secure_config plugin.gerrit-oauth-provider-google-oauth.client-secret "${OAUTH_GOOGLE_CLIENT_SECRET}"

echo ' Done.'
