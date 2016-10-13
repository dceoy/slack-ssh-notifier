#!/usr/bin/env bash

set -e

[[ "${1}" = '--debug' ]] && set -x

ROOT_DIR="$(dirname ${0})"
set -u

IGNORED_IP=(127.0.0.1)
ME="$(whoami)"
TEXT="$(who | grep -e "^${ME} \\+" | tail -1)"
IP="$(echo ${TEXT} | grep -oe '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')"
NOTIFY_SH="${ROOT_DIR}/slack_notify.sh"

for ignored in ${IGNORED_IP[@]}; do
  [[ "${ignored}" = "${IP}" ]] && exit 0
done

${NOTIFY_SH} "[$(LANG=C date)]\t${TEXT}"
