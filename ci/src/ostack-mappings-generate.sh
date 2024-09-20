#!/usr/bin/env bash
# Generate OpenStack identity mappings
# ostack-mappings-generate.sh <input-project-quota-acls-manifests-dir> <input-static-identity-mappings-dir> <output-identity-mappings-dir>

set -eo pipefail

SCRIPT_DIR="$(dirname $(readlink -f $0))"

INPUT_PROJECT_QUOTA_ACLS_DIR="$1"
INPUT_IDENTITY_MAPPINGS_DIR="$2"
OUTPUT_IDENTITY_MAPPINGS_DIR="$3"
INPUT_IDENTITY_MAPPING_FILE_SUFFIX="gsi-mapping.yaml"
OUTPUT_OSTACK_MAPING_FILE_SUFFIX="mapping-rules.json"

test -d "${INPUT_IDENTITY_MAPPINGS_DIR}"
test -d "${OUTPUT_IDENTITY_MAPPINGS_DIR}" || mkdir -p "${OUTPUT_IDENTITY_MAPPINGS_DIR}"

echo "Ostack mappings generation started."

INPUT_IDENTITY_MAPPING_FILES=$(find "${INPUT_IDENTITY_MAPPINGS_DIR}" -type f -name "*-${INPUT_IDENTITY_MAPPING_FILE_SUFFIX}")

echo -e "Input GSI mapping files found (count: $(echo "${INPUT_IDENTITY_MAPPING_FILES}" | wc -w), files: ${INPUT_IDENTITY_MAPPING_FILES})\n"

for i_identity_mapping_file in ${INPUT_IDENTITY_MAPPING_FILES}; do
    i_identity_mapping_file_name=$(basename ${i_identity_mapping_file})
    i_output_identity_mapping_file="${OUTPUT_IDENTITY_MAPPINGS_DIR}/${i_identity_mapping_file_name%${INPUT_IDENTITY_MAPPING_FILE_SUFFIX}}${OUTPUT_OSTACK_MAPING_FILE_SUFFIX}"

    echo "OpenStack mapping generation ${i_identity_mapping_file} started"

    ${SCRIPT_DIR}/ostack-mapping-generate.py \
      --input-psi-mapping-dir "$(dirname ${INPUT_IDENTITY_MAPPINGS_DIR})" \
      --input-gsi-mapping-file "${i_identity_mapping_file}" \
      --output-ostack-identity-mapping-file "${i_output_identity_mapping_file}"
    echo "... generation succeeded, stored as ${i_output_identity_mapping_file}"
    jq -c . ${i_output_identity_mapping_file} >/dev/null
    echo "... json validated"
done

echo -e "\nOstack mappings generation finished - All ostack mappings successfully generated."
