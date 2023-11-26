#!/opt/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ]; then
	echo "usage: purge_dirs.sh {directory} {retain#}"
	exit
fi

purge_dir=$1
keep_num=$2

echo "purging directory $purge_dir retaining $keep_num latest dirs"

if ! test -d $purge_dir; then
	echo "ERROR $purge_dir not found!"
	exit
fi

how_many=`ls $purge_dir | wc -l`
#echo "how many: $how_many"

if [ "$how_many" -le "$keep_num" ]; then
	echo "$purge_dir already purged"
	exit
fi

head_val=`expr $how_many - $keep_num`

cd $purge_dir

#files_tot=`ls -t $purge_dir`

#echo "$files_tot"

files=`ls -t | head -$head_val`

for file in $files; do
	if test -d $file; then
		echo "purging $file..."
		rm -fr $file
	fi
done
