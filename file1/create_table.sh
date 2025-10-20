#!/usr/bin/env bash

echo "Creating a new table"

while true
do
    read -p "Enter table name: " table_name

    # empty name
    if [[ -z "$table_name" ]]; then
        echo " Table name can't be empty"
        continue
    fi

    # no spaces
    if [[ "$table_name" =~ [[:space:]] ]]; then
        echo " Table name can't contain spaces"
        continue
    fi

    # must start with a letter or underscore
    if [[ ! "$table_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo " Invalid name: must start with letter or underscore"
        continue
    fi

    # check if table already exists
    if [ -f "$table_name" ]; then
        echo " Table already exists"
        continue
    else
        touch "$table_name"
        echo " Table '$table_name' created successfully"
        break
    fi
done


# === number of fields ===
while true
do
    read -p "Insert number of fields for $table_name table: " fields_num
    case $fields_num in
        ''|*[!0-9]*)
            echo " Please enter a valid number"
            ;;
        0)
            echo " Number of fields can't be 0"
            ;;
        *)
            echo "Total fields: $fields_num"
            break
            ;;
    esac
done


# === columns data (names + types) ===
header=""
types=""

for (( i=1; i<=fields_num; i++ ))
do
    while true
    do
        read -p "Enter name for column $i: " col_name

        # validate name
        if [[ -z "$col_name" ]]; then
            echo " Column name can't be empty"
            continue
        fi
        if echo "$header" | grep -qw "$col_name"; then
            echo " Column '$col_name' already exists"
            continue
        fi

        # === choose column type ===
        echo "Select type for column '$col_name' (only string or integer):"
        select col_type in string integer
        do
            case $col_type in
                string )
                    echo "Column $col_name type = string"
                    ;;
                integer )
                    echo " Column $col_name type = integer"
                    ;;
                * )
                    echo " Invalid choice, only 1 or 2 are allowed"
                    continue
                    ;;
            esac
            break
        done

        # add to headers + types
        if [ $i -eq 1 ]; then
            header="$col_name"
            types="$col_type"
        else
            header="$header:$col_name"
            types="$types:$col_type"
        fi
        break
    done
done

# save metadata
{
    echo "$header"
    echo "$types"
} > "$table_name"

echo " Table structure saved!"
echo " Columns: $header"
echo " Types:   $types"

