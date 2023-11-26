#!/bin/bash

containers=`sudo -u multiwp cat /home/multiwp/multi-wordpress/docker-compose.yml | grep container_name | awk '{ print $2 }'`

containers="$containers plex_notify"

output_str=""
raise_alarm="false"

for container in $containers; do
	if docker container ls | grep "$container" > /dev/null; then
		output_str=`echo "$output_str"; echo "container $container is running"`
	else
		output_str=`echo "$output_str"; echo "container $container is not running"`
		raise_alarm="true"
	fi
done

echo "$output_str"

if [ "$raise_alarm" == "true" ]; then
	echo "sending alarm notification"
fi
