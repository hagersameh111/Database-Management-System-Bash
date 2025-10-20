#!/usr/bin/env bash

echo "Select table number to delete data from:"

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
        > "$table_name"
        echo "All data deleted from table '$table_name'"
        break
    fi
done

