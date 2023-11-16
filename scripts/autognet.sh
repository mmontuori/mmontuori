#!/opt/bin/bash

login="mietanza"
pass="Italian71"
host="gnetonline.org:2121"
remote_dir='~/complete/mietanza/'
local_dir="/share/Public/media-library/video/tmp"
tvshow_dir="/share/Public/media-library/video/TV Shows"
movie_dir="/share/Public/media-library/video/Movies/Movie"
rar_tmp_file="/tmp/rar-files.txt"
FIND_CMD="/opt/bin/find"

base_name="$(basename "$0")"
base_name=`echo $base_name |sed 's/\.sh//g'`
lock_file="/tmp/$base_name.lock"

trap "rm -f $lock_file; exit 0" SIGINT SIGTERM

if [[ -e "$lock_file" ]]
then
    echo "$base_name is running already."
    exit
else
    echo "downloding files..."
    touch "$lock_file"
    ionice -c2 -n7 nice -n19 /opt/bin/lftp -u $login,$pass $host << EOF
    #set ftp:ssl-allow no
    #set mirror:use-pget-n 2
    #mirror  -v --Remove-source-file -c -P "$remote_dir" "$local_dir"
    mirror  -v --Remove-source-file -c "$remote_dir" "$local_dir"
    quit
EOF
fi

cd $local_dir

$FIND_CMD . -maxdepth 1 -type d > $rar_tmp_file
while read file; do
	if ls $file/*.rar>/dev/null 2>&1; then
		cd $file
		rarfile=`ls *.rar`
		echo "unrar file: $rarfile..."
		/opt/bin/unrar x "$rarfile"
		rm -f *.r??
		cd ..
	fi
done<$rar_tmp_file
rm $rar_tmp_file
                                                                                                
files=`$FIND_CMD . -name \*.mkv | grep -v -i sample`
for file in $files; do
	base_name=`basename $file`
	if echo $base_name | grep "\.[S|s]..[E|e]..\." > /dev/null; then
		echo "TV Show: Moving $file to $tvshow_dir..."
		mv "$file" "$tvshow_dir"
		/usr/sbin/sendemail -f michael.montuori@gmail.com -t michael.montuori@gmail.com -s "New TV Show has been downloaded" -c "TV Show $base_name has been downloaded"
	else
		echo "Not TV Show: assume it's a Movie: $file"
		mv "$file" "$movie_dir"
	fi	
done

echo "removing files from directory $local_dir older than 10 days..."
$FIND_CMD ${local_dir}/* -ctime +10 -exec rm {} \;
$FIND_CMD ${local_dir}/* -type d -ctime +10 -exec rm -fr {} \;

## lftp option(s) removed
#    mirror -c -P5 --log="/var/log/$base_name.log" "$remote_dir" "$local_dir"

rm -f "$lock_file"
trap - SIGINT SIGTERM
