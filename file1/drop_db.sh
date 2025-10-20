#!/usr/bin/env bash
cd ../file2 || exit

echo "Dropping database"
echo "Select the number of database to drop:"

# Make array of directories
array=( $(ls -F | grep / | tr -d '/') )

select choice in "${array[@]}"
do
    # Check invalid choice
    if [ "$REPLY" -gt "${#array[@]}" ] || [ "$REPLY" -lt 1 ]; then
        echo "$REPLY not on the menu"
        continue
    fi

    # Delete database
    rm -r "${array[$((REPLY-1))]}"
    echo "Your database '${choice}' has been deleted "
    break
done

cd -

