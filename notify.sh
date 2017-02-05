#!/usr/bin/env bash

set -e

[[ "${1}" = '--debug' ]] && set -x

source "$(dirname ${0})/slack_env.sh"
# => SLACK_CHANNEL, SLACK_WEBHOOK_URL, SLACK_USERNAME, SLACK_ICON_URL, IGNORED_IP

function slack_notify {
  curl -sSX POST --data-urlencode \
    "payload={'channel': '${SLACK_CHANNEL}', \
              'username': '${SLACK_USERNAME}', \
              'text': '${*}', \
              'icon_url': '${SLACK_ICON_URL}'}" \
    ${SLACK_WEBHOOK_URL} > /dev/null
}

set -u

ME="$(whoami)"
TEXT="$(who | grep -e "^${ME} \\+" | tail -1)"
IP="$(echo ${TEXT} | grep -oe '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')"

for ignored in ${IGNORED_IP[@]}; do
  [[ "${ignored}" = "${IP}" ]] && exit 0
done

slack_notify "${TEXT}"
