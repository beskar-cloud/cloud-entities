#!/usr/bin/env bash
# 
# install-apt-repo.sh <repo-url> [repo-keyring-url] [repo-keyring-file]
# 
# installs APT repository
# * <repo-url>             i.e. apt repository URL
# * [repo-keyring-url]     i.e. apt repository public keyring URL
# * [repo-keyring-file]    i.e. apt repository keyring local file
#
# Note: Only Debin-like Linux distros supported
# Example: ./install-apt-repo.sh https://apt.releases.hashicorp.com \
#                                https://apt.releases.hashicorp.com/gpg \
#                                /etc/apt/trusted.gpg.d/hashicorp.gpg

set -eo pipefail

APT='apt -y'

REPO_URL="$1"
REPO_KEYRING_URL="$2"
REPO_KEYRING_FILE="$3"

if [ -z "${REPO_URL}" ]; then
    echo "Invalid <repo-spec> (${REPO_URL})"
    exit 1
fi

${APT} update
${APT} install software-properties-common gnupg2 curl

if [ -n "${REPO_KEYRING_URL}" -a -n "${REPO_KEYRING_FILE}" ]; then
    curl -L "${REPO_KEYRING_URL}" | gpg --dearmor > /tmp/$(basename "${REPO_KEYRING_FILE}")
    install -o root -g root -m 644 /tmp/$(basename "${REPO_KEYRING_FILE}") $(dirname "${REPO_KEYRING_FILE}")
fi

apt-add-repository "deb [arch=$(dpkg --print-architecture)] ${REPO_URL} $(awk -F= '$1=="UBUNTU_CODENAME"{print $2}' /etc/os-release) main"

${APT} update
