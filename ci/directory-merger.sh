#!/usr/bin/env bash
# Merge common files from soure directory or directories, this files will be owerwritten by files from destionation directory if it exists.
# Usage:
# * directory-merger <destination-dir> <source-dir-A> [source-dir-B] ...
set -eo pipefail

DESTINATION_DIR="$1"
TEMP_DIR=""

if [ -z "$DESTINATION_DIR" ]; then
    echo 1>&2 "<destination-dir> is empty string"
    exit 2
elif [ -f "$DESTINATION_DIR" ]; then
    echo 1>&2 "<destination-dir> ($DESTINATION_DIR) exists as a file, delete it and execute again"
    exit 2  
fi

for i_dir in "$@"; do
    if [ ! -d "${i_dir}" ]; then
        echo 1>&2 "<source-dir> (${i_dir}) doesn't exists"
        exit 2  
    fi
done
shift

function cleanup() {  
    if [ -n "$TEMP_DIR" ]; then
        rm -rf "${TEMP_DIR}"
    fi
} 

trap cleanup EXIT

DIRS=()

for i_dir in "$@"; do
    if [ -n "${DESTINATION_DIR}" -a -d "${DESTINATION_DIR}" -a \
        "$(stat --format=%i "${DESTINATION_DIR}")" == "$(stat --format=%i "${i_dir}")" ]; then
        if [[ -z "$TEMP_DIR" ]]; then
            TEMP_DIR=$(mktemp -d) 
            mv -f "${i_dir}" "${TEMP_DIR}"
            DIRS+=("${TEMP_DIR}/$(basename ${i_dir})")
        fi
    else
        DIRS+=(${i_dir})
    fi
done

if [ ! -d "${DESTINATION_DIR}" ]; then
    mkdir -p "${DESTINATION_DIR}"
fi

for i_dir in "${DIRS[@]}"; do
    cp -rf ${i_dir}/. "${DESTINATION_DIR}"
done
