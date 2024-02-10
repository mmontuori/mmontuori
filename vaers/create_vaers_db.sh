#!/bin/bash

#CREATE TABLE table_name (
            #id INT NOT NULL AUTO_INCREMENT,
            #column_1 VARCHAR(255) NOT NULL,
            #column_2 DATE NOT NULL,
            #column_3 DECIMAL(10 , 2 ) NULL,
            #column_4 INTEGER,
            #PRIMARY KEY (id)
#);

if [ "$1" == "" ]; then
    echo "usage: `basename $0` {CSV FILE}"
    exit 1
fi

create_stmt="create table v_data ("
first_comma="true"

for column in `cat ${1} | head -1 | sed 's/,/ /g'`; do
    if [ "$first_comma" == "true" ]; then
        first_comma="false"
    else
        create_stmt="${create_stmt}, "     
    fi
    create_stmt="${create_stmt} ${column} varchar(255)"
done

create_stmt="${create_stmt} )"

echo "${create_stmt}"

exit

echo "drop database vaers;" | mysql -p

echo "creating database VAERS..."
echo "create database vaers DEFAULT CHARACTER SET latin1;" | mysql -p

echo "creating DATA table..."
echo "${create_stmt};" | mysql -p --database vaers

echo "[mysqld]" > /etc/mysql/mysql.conf.d/securefile.cnf 
echo "secure_file_priv=\"\"" >> /etc/mysql/mysql.conf.d/securefile.cnf
