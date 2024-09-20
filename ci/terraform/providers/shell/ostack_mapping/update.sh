#!/bin/bash

set -eo pipefail

source ${ACTIONS_DIR:-.}/lib.sh

trap at_exit EXIT

STEP_NAME="Read TF provider stdin arguments"
IN=$(cat)

STEP_NAME="Assert input arguments"
test -n "${NAME}"
test -n "${RULES_FILE}"
test -s "${RULES_FILE}"

STEP_NAME="Compute input/local mapping rules checksum"
local_mapping_rules_json_checksum=$(cat "${RULES_FILE}" | jq -c . | get_checksum)

STEP_NAME="Update OpenStack mapping"
openstack mapping set --rules "${RULES_FILE}" "${NAME}"

STEP_NAME="Read OpenStack mapping"
mapping_json=$(openstack mapping show "${NAME}" -f json)

STEP_NAME="Compute remote OpenStack mapping rules checksum"
ostack_mapping_rules_json_checksum=$(echo "${mapping_json}" | jq -c '.rules' | get_checksum)

STEP_NAME="Dump TF provider state"
printf "${SCHEMA_JSON}" "${NAME}" \
       "${local_mapping_rules_json_checksum}" "${ostack_mapping_rules_json_checksum}"

STEP_NAME="Succeeded"
