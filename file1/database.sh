#!/usr/bin/bash
select choice in CREATE_DB CONNECT_DB DROP_DB LIST_DB
do
       	case $choice in
       	CREATE_DB )
       		echo "creating database"
       		source ./create_db.sh
		;;
	CONNECT_DB )
	       	echo "connecting database"
		source ./connect_db.sh
		;;
	DROP_DB )
	       	echo "droping database" 
		source ./drop_db.sh
		;;
	LIST_DB )
	       	echo "listing database"
		source ./list_db.sh
	;;
esac
done
