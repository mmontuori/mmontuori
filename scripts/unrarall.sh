#!/bin/bash

find . -maxdepth 1 -type d > /tmp/files.txt

while read file; do
	if ls $file/*.rar>/dev/null 2>&1; then
		cd $file
		rarfile=`ls *.rar`
		echo Unrar file: $rarfile...
		unrar x "$rarfile"
		cd ..
	fi
done</tmp/files.txt
