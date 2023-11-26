#!/bin/bash

backup_config="/home/ubuntu/git-repos/mmontuori/etc/docker_db_backup.conf"
backup_dir="/opt/backup"

if ! test -f ${backup_config}; then
	echo "ERROR: file ${backup_config} not found!"
	exit 1
fi

while read config_line; do
	if echo $config_line | grep "^#">/dev/null; then
		continue
	fi
	container=`echo ${config_line} | awk -F, '{ print $1 }'`
	database=`echo ${config_line} | awk -F, '{ print $2 }'`
	user=`echo ${config_line} | awk -F, '{ print $3 }'`
	psw=`echo ${config_line} | awk -F, '{ print $4 }'`
	backup_file="${backup_dir}/${database}-`date +%Y%m%d%H%M`.sql"
	echo -n "backing up DB ${database} in container ${container} to ${backup_file}..."
	if ! docker exec ${container} mysqldump -u ${user} -p${psw} ${database} > ${backup_file}; then
		echo "ERROR backing up database"
	else
		echo "OK"
	fi
	echo -n "compressing ${backup_file}..."
	if ! gzip ${backup_file}; then
		echo "ERROR"
	else
		echo "OK"
	fi
done<$backup_config
