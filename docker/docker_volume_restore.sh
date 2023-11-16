#!/bin/bash

if [ "$1" == "" ]; then
	echo "usage: docker_volume_restore.sh {backup_file} {destination volume}"
	exit 1
fi

backup_file="$1"
dest_vol="$2"

echo "restoring ${backup_file} -> volume:${dest_vol}..."
echo "#!/bin/bash" > /opt/backup/restore.sh
echo "apt update" >> /opt/backup/restore.sh
echo "apt install -y bzip2" >> /opt/backup/restore.sh
echo "cd /volume" >> /opt/backup/restore.sh
echo "tar xvfj /backup/\${1}" >> /opt/backup/restore.sh
chmod 755 /opt/backup/restore.sh
docker run -ti -v ${dest_vol}:/volume -v /opt/backup:/backup --rm ubuntu:22.04 /backup/restore.sh ${backup_file}
