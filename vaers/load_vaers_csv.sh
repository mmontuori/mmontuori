#!/bin/bash

function usage {
	echo "usage: `basename $0` {CSV FILE} {TABLE NAME}"
}

if [ "$1" == "" ]; then
	usage
	exit
fi

if [ "$2" == "" ]; then
	usage
	exit
fi

csv_file="$1"
table_name="$2"

echo "importing csv file: ${csv_file} into table: ${table_name}..."

tmp_dir=`mktemp -d`

echo "using temporaty directory ${tmp_dir}"

cp ${csv_file} ${tmp_dir}

chmod -R 755 ${tmp_dir}

sudo chown -R mysql:mysql ${tmp_dir}

tmp_csv_file=`basename ${csv_file}`

echo "LOAD DATA INFILE '${tmp_dir}/${tmp_csv_file}' \
INTO TABLE ${table_name} \
CHARACTER SET 'latin1' \
FIELDS TERMINATED BY ',' \
ENCLOSED BY '\"' \
LINES TERMINATED BY '\r\n' \
IGNORE 1 ROWS;" | mysql -p --database vaers

sudo rm -fr ${tmp_dir}

exit

LOAD DATA INFILE '/tmp/vaers1990.csv' INTO TABLE v_data CHARACTER SET 'latin1' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

