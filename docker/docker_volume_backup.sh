#!/bin/bash

volumes=`docker volume list | grep -v DRIVER | awk '{ print $2 }'`
backup_dir="/opt/backup"
volumes_to_backup=""
backup_retention_dyas="10"

for volume in $volumes; do
	name_length=`echo $volume | wc -m`
	if [ "$name_length" == "65" ]; then
		continue
	fi
	volumes_to_backup="$volumes_to_backup $volume"
done

for volume_to_backup in $volumes_to_backup; do
	echo "backing up $volume_to_backup -> ${backup_dir}..."
	docker run -v ${volume_to_backup}:/volume -v /opt/backup:/backup --rm loomchild/volume-backup backup ${volume_to_backup}-`date +%Y%m%d%H%M`
done

echo "cleaning old files..."

find ${backup_dir} -mtime +${backup_retention_dyas} | xargs rm -f
