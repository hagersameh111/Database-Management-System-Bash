#!/usr/bin/env bash

echo "=== UPDATE ROW ==="

read -p "Enter table name: " table_name

if [ ! -f "$table_name" ]; then
    echo "Table '$table_name' does not exist"
    exit 1
fi

header=$(sed -n '1p' "$table_name")
types=$(sed -n '2p' "$table_name")

echo "Columns: $header"
IFS=":" read -r -a columns <<< "$header"

read -p "SET column: " set_col
read -p "New value: " new_val

read -p "WHERE column: " where_col
read -p "WHERE value: " where_val

where_index=-1
set_index=-1
for i in "${!columns[@]}"; do
    if [[ "${columns[$i]}" == "$where_col" ]]; then
        where_index=$i
    fi
    if [[ "${columns[$i]}" == "$set_col" ]]; then
        set_index=$i
    fi
done

if [[ $where_index -eq -1 ]]; then
    echo "Column '$where_col' not found"
    exit 1
fi
if [[ $set_index -eq -1 ]]; then
    echo "Column '$set_col' not found"
    exit 1
fi

tmp_file="$table_name.tmp"

{
    head -n 2 "$table_name"
    tail -n +3 "$table_name" | while IFS=":" read -r -a row; do
        if [[ "${row[$where_index]}" == "$where_val" ]]; then
            row[$set_index]="$new_val"
        fi
        (IFS=":"; echo "${row[*]}")
    done
} > "$tmp_file"

mv "$tmp_file" "$table_name"
echo " Row updated successfully!"

