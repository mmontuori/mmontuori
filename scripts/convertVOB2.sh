#!/bin/bash    
#####Needed packages: vobcopy,ffmpeg,libdvdread,libdvdcss,libdvdread2-dev#####
##########Scripy By Mystkid (nicolast88@gmail.com)############################
##############################################################################
dump="$HOME/dvdrip/vob"                ##default:"$HOME/dvdrip/vob"
output="$HOME/dvdrip/out"            ##default:"$HOME/dvdrip/out"   output folder
vobargs="-l -x -o"                ##default:"-l -x -o"           vobcopy options
ffmpegargs="-target pal-svcd"            ##default:"-target pal-svcd"   ffmpeg options
format=".mpg"                    ##default:".mpg"           output format
REQUIREMENTS=${REQUIREMENTS:-"vobcopy ffmpeg"}
##############################################################################
##############################################################################
type -P $REQUIREMENTS &>/dev/null || { echo "Missing Something ?" >&2; exit 1; }
shopt -s nocaseglob
set -e
echo -e '\E[37;44m\033[1mDVD to MPG Script\033[0m'
echo -en '\E[37;31m'"\033[1mCreating folders.\033[0m"
if [ ! -d "$dump" ]; then
        echo '* Making dump directory'
        mkdir -p $HOME/dvdrip/vob
    mkdir -p $HOME/dvdrip/out
else
    echo "* $dump exists."
fi
##############################################################################
##############################################################################
echo -en '\E[37;31m'"\033[1mTaking a VOB dump\033[0m"
vobcopy $vobargs "$dump"
##############################################################################
##############################################################################
echo '* Re-encoding with FFmpeg'
echo -en '\E[37;31m'"\033[1m* Re-encoding with FFmpeg\033[0m"
##############################################################################
##############################################################################
for vobinput in "$dump"/*.vob; do
    dvdname=${vobinput%%/VIDEO_TS/*} dvdname=${dvdname##*/}; 
ffmpeg -i "$vobinput" $ffmpegargs "$output/${dvdname%.*}$format"
done
##############################################################################
##############################################################################
echo -en '\E[37;31m'"\033[1m* Deleting VOB dump\033[0m"
rm -rf $dump/*.*
##############################################################################
##############################################################################
echo -e '\E[47;32m\033[1mDone!\033[0m'
echo -en '\E[37;31m'"\033[1mScript By MystKid.\033[0m"
##############################################################################
###################################End########################################
##############################################################################

