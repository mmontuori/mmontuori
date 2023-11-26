#!/opt/bin/bash

IFS=$','
FIND_CMD="/opt/bin/find"

movie_dirs="/share/Public/media-library/video/Movies/Italian,/share/Public/media-library/video/Movies/Movie,/share/Public/media-library/video/Movies/kids"
tv_dirs="/share/Public/media-library/video/TV Shows"

echo "cleaning TV Show directories..."
for dir in $tv_dirs; do
	if test -d "$dir"; then
		echo "cleaning directory $dir..."
		$FIND_CMD "$dir" -type f -mtime +730 -print -exec rm {} \;
	fi
done

echo "cleaning Movie directories..."
for dir in $movie_dirs; do
	if test -d "$dir"; then
		echo "cleaning directory $dir..."
		$FIND_CMD "$dir" -type f -mtime +730 -print -exec rm {} \;
	fi
done
