#!/bin/bash

set -eo pipefail

source ${ACTIONS_DIR:-.}/lib.sh

STEP_NAME="Read TF provider stdin arguments"
IN=$(cat)

STEP_NAME="Assert input arguments"
test -n "${NAME}"
test -n "${RULES_FILE}"

local_mapping_rules_json_checksum=""
if [ -s "${RULES_FILE}" ]; then
    STEP_NAME="Compute input/local mapping rules checksum (if ${RULES_FILE} exists only)"
    local_mapping_rules_json_checksum=$(cat "${RULES_FILE}" | jq -c . | get_checksum)
fi

STEP_NAME="Delete OpenStack mapping"
openstack mapping delete "${NAME}"

STEP_NAME="Dump TF provider state"
printf "${SCHEMA_JSON}" "${NAME}" "${local_mapping_rules_json_checksum}" ""

STEP_NAME="Succeeded"
