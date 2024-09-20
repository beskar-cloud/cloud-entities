#!/usr/bin/env bash
# 
# install-pkgs.sh <pkg-requirement-file> ...  [package-name] ...
# 
# installs linux packages from various sources
# * <pkg-requirement-file> i.e. packages listed in text file
# * [package-name]         i.e. explicitly listed packages
#
# Note: Only Debian-like Linux distros supported

set -eo pipefail

APT='apt -y'

function install_pkgs_from_requirement_file() {
    local file="$1"
    if  [ "$(grep -v '^#' "${file}" | wc -w)" -gt "0" ]; then
        ${APT} install $(grep -v '^#' "${file}")
    fi
}

function install_pkgs() {
    ${APT} install "$@"
}

${APT} update

for i_arg in "$@"; do
  if [ -r "${i_arg}" ]; then
      install_pkgs_from_requirement_file "${i_arg}"
  else
      install_pkgs "${i_arg}"
  fi
done

