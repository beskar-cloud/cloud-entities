#!/usr/bin/env bash
# 
# install-ansiblemodules.sh <ansiblemodules-requirement-file> [ansiblemodule-name] ...
# 
# installs ansible modules from various sources
# * <ansiblemodules-requirement-file>  i.e. modules listed in text file
# * [ansiblemodule-name]               i.e. explicitly named modules

set -eo pipefail

AG='ansible-galaxy'

function install_mods_from_requirement_file() {
    local file="$1"
    ${AG} collection install --requirements-file "${file}"
}

function install_mods_from_requirement_file_alternative() {
    local file="$1"
    ${AG} collection install $(grep -v '^#' ${file})
}

function install_mods() {
    ${AG} collection install "$@"
}

for i_arg in "$@"; do
  if [ -r "${i_arg}" ]; then
      install_mods_from_requirement_file "${i_arg}"
  else
      install_mods "${i_arg}"
  fi
done

