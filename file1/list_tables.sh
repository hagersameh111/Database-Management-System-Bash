#!/usr/bin/env bash

echo "Listing tables..."

array=($(ls -p | grep -v /))

if [ ${#array[@]} -eq 0 ]; then
    echo "No tables in current database."
else
    echo "The existing tables:"
    for t in "${array[@]}"; do
        echo " - $t"
    done
fi

