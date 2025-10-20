#!/usr/bin/env bash

echo
echo "Select number from menu"
echo

cd ../file2 || { echo "file2 not found"; exit 1; }

array=($(ls -F | grep / | tr -d '/'))

if [ ${#array[@]} -eq 0 ]; then
    echo "No databases found."
    exit 1
fi

select choice in "${array[@]}"
do 
    if [ "$REPLY" -gt "${#array[@]}" ] || [ "$REPLY" -lt 1 ]; then
        echo " $REPLY not on menu"
        continue
    else
        cd "${array[$((REPLY-1))]}" || { echo " Cannot access DB"; exit 1; }
        CURRENT_DB="${array[$((REPLY-1))]}"
        export CURRENT_DB
        echo " You are connected to $CURRENT_DB DB"
        echo
        break
    fi
done

# === Operations Menu ===
while true
do
    select choice in create_table list_tables drop_tables insertinto_table select_table delete_table UPDATE_ROW exit
    do 
        case $choice in 
            create_table )
                echo " Creating tables..."
                source /home/hager/ITI/DATABASE/file1/create_table.sh
                ;;
            list_tables )
                echo " Listing tables..."
                source /home/hager/ITI/DATABASE/file1/list_tables.sh
                ;;
            drop_tables )
                echo " Dropping a table..."
                source /home/hager/ITI/DATABASE/file1/drop_tables.sh
                ;;
            insertinto_table )
                echo " Inserting into table..."
                source /home/hager/ITI/DATABASE/file1/insertinto_tables.sh
                ;;
            select_table )
                echo " Selecting from table..."
                source /home/hager/ITI/DATABASE/file1/select_table.sh
                ;;
            delete_table )
                echo " Deleting from table..."
                source /home/hager/ITI/DATABASE/file1/delete_table.sh
                ;;
                UPDATE_ROW )
            source /home/hager/ITI/DATABASE/file1/update_row.sh
            ;;
            exit )
                echo " Leaving database..."
                cd - >/dev/null
                exit 0
                ;;
            * )
                echo " Not a valid choice"
                ;;
        esac
        break
    done
done

