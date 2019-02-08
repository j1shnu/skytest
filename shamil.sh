#!/bin/bash
a="amri"
b="old"
if [[ $1 -eq 15 ]]; then
	echo "test1 $1"
#	/etc/init.d/postgresql-9.5 stop	
#	su - postgres -c "/opt/PostgreSQL/9.5.15/bin/pg_ctl -D  /opt/PostgreSQL/9.5.15/data start"
#	echo $?
#fi
elif [[ $1 -eq 10 ]]; then
	echo "test2 $1"
#	su - postgres -c "/opt/PostgreSQL/9.5.15/bin/pg_ctl -D /opt/PostgreSQL/9.5.15/data/ stop"
#	echo "stopping amri $?"
#	/etc/init.d/postgresql-9.5 start
#	echo "starting old$?"
fi
