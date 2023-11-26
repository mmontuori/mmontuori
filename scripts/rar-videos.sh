#!/bin/bash

dirs="/home/michael/Videos/Bambini"
dest_dir="/home/michael/box/box10/Videos/Bambini"
tmp_file="/tmp/dirs.txt"
#rar a -m5 -v50M

rm $tmp_file

for dir in $dirs; do
	cd $dir
	find * -type d >$tmp_file
done

while read dir; do
	if ! test -d "${dest_dir}/$dir"; then
		echo creating directory ${dest_dir}/$dir...
		mkdir -p "${dest_dir}/$dir"
	else
		echo directory ${dest_dir}/$dir already exists
	fi
done<$tmp_file

rm $tmp_file

for dir in $dirs; do
        cd $dir
        find * -type f -size -90M >$tmp_file
done

while read file; do
	echo rsync "$file" "$dest_dir/$file"
	rsync "$file" "$dest_dir/$file"
done<$tmp_file

rm $tmp_file

for dir in $dirs; do
        cd $dir
        find * -type f -size +90M >$tmp_file
done

while read file; do
	echo rar file $file...
        rar a -m5 -v99M "$dest_dir/$file.rar" "$file"
done<$tmp_file
