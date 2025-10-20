#!/usr/bin/env bash

echo "Select table number to drop:"

array=($(ls -p | grep -v /))

if [ ${#array[@]} -eq 0 ]; then
    echo "No tables found."
    exit 1
fi

select choice in "${array[@]}"
do
    if [ "$REPLY" -gt "${#array[@]}" ] || [ "$REPLY" -lt 1 ]; then
        echo "$REPLY is not in menu"
        continue
    else
        table_name="${array[$((REPLY-1))]}"
        rm -r "$table_name"
        echo "Table '$table_name' dropped"
        break
    fi
done

