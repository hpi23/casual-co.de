#!/usr/bin/env bash

#
# Setup configuration file.
#

URL="${SMARTHOME_URL}"
TOKEN="${SMARTHOME_TOKEN}"

echo "URL=${URL}; TOKEN=${TOKEN}"

FILE=$(sed -i /root/.config/smarthome-cli-rs/config.toml)
FILE=$(cat "${FILE}" | sed -e "s/URL_PLACEHOLDER/${URL}/g")
FILE=$(cat "${FILE}" | sed -e "s/TOKEN_PLACEHOLDER/${TOKEN}/g")

python3 -m http.server --cgi
