#!/bin/sh

lock_file="/var/run/`basename $0`.lock"

cleanup() {
	rm $lock_file
}

if test -f $lock_file; then
	echo "another instance of $0 is running"
	exit 1
fi

SPRINKLE_HOME="/share/Public/git-repos/sprinkle"
if ! test -d $SPRINKLE_HOME; then
	echo "SPRINKLE_HOME $SPRINKLE_HOME not found!"
	exit 1
fi

dir_file="/share/Public/git-repos/mmontuori/sprinkle/sprinkle-dirs.conf"
if ! test -f $dir_file; then
	echo "directory file $dir_file not found"
	cleanup
	exit 1
fi
touch $lock_file

cd $SPRINKLE_HOME

while read dir; do
	if echo "$dir" | grep "^#" > /dev/null; then
		continue
	fi
	sprinkle_dir=`basename $dir`
	rclone_conf="/share/Public/git-repos/mmontuori/rclone/rclone-${sprinkle_dir}.conf"
	if ! test -f $rclone_conf; then
		echo "cannot execute sprinkle, config file $rclone_conf not found"
		continue
	fi
	echo "invoking sprinkle command: ./sprinkle.py --delete-files --rclone-conf $rclone_conf backup $dir /"
	./sprinkle.py --delete-files --rclone-conf $rclone_conf backup $dir /
done<${dir_file}

cleanup
