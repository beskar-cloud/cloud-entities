#!/bin/bash
# $1 image_source_url, $2 checksum_file_path

image_url_name=$(echo $1 | rev | cut -d/ -f1 | rev)
checksum_line=$(cat $2 | grep $image_url_name)
export IFS=" "
for string in $checksum_line; do
    if echo $string | wc --chars | grep -q 65; then echo $string; break; fi
done
