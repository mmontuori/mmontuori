function usage
{
	echo "usage: `basename $0` -d device -t threads -b build -c"
	echo "    -d = device to build"
	echo "    -t = number of threads"
	echo "    -b = build type"
	echo "    -c = clean up before build"
}

threads=12
build=

while getopts ":d:t:b:c" opt; do
	case $opt in
		d)
			device=$OPTARG
			;;
		t)
			threads=$OPTARG
			;;
		b)
			build=$OPTARG
			;;
		c)
			clean=true
			;;
		*)
			usage
			exit
			;;
	esac
done

if [ "$device" == "" ]; then
	usage
	exit
fi

if ! test -f build/envsetup.sh; then
	echo "ERROR: must be in CM ROOT"
	exit
fi

. build/envsetup.sh
export JAVA_HOME=~/android/jdk1.6.0_33

if [ "$build" != "" ]; then
	lunch cm_${device}-${build}
else
	breakfast ${device}
fi

if [ "$clean" == "true" ]; then
	echo "cleaning..."
	make dataclean
	make installclean
	if test -d out; then
		rm -fr out
	fi
fi

mka -j ${threads} bacon
