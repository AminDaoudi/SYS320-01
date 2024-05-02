#!/bin/bash

#checking the number of correct arguments

if [ "$#" ----ne 2 ]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    exit 1
fi

#arguments to variables
log_file="$1"
ioc_file="$2"
#loop
while IFS= read -r ioc_pattern; do
    grep "$ioc_pattern" "$log_file" | awk '{sub(/^\[/, "", $4); print $1, $4, $7}' >> report.txt
done < "$ioc_file"

echo "saved to report.txt"
