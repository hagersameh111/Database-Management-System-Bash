#!/usr/bin/env bash
cd ../file2 || exit

while true
do
    echo "write your database name: "
    read db_name

    # empty name
    if [[ -z "$db_name" ]]; then
        echo "the name can't be empty"
        continue
    fi

    # no spaces
    if [[ "$db_name" =~ [[:space:]] ]]; then
        echo "the name can't have spaces"
        continue
    fi

    # must start with a letter or underscore
    if [[ ! "$db_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "the name can't start with a number or invalid char"
        continue
    fi

    # check if directory exists
    if [ -d "$db_name" ]; then
        echo "there is another database with the same name"
        continue
    else
        mkdir "$db_name"
        echo "Database '$db_name' created successfully" 
        break
    fi
done

