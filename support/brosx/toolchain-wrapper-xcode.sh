#!/bin/bash

thisDir=`dirname $0`
cmd=`basename $0`
args=( "$@" )

logFile=$BROSX_TOOLCHAIN_WRAPPER_LOG_FILE
hostDir=$BROSX_HOME/output/host

info() {
	if [ "x$logFile" != "x" ]; then
		echo "[$(date +"%T") - $tcName] $1" >> $logFile
	fi	
}

error() {
	echo "[$(date +"%T") - $tcName] $1"
	exit
}


tcName="xcode"
mappedCmd=$cmd
var=BROSX_TOOLCHAIN_CMD_${cmd^^}
var=`echo $var | sed "s/\+\+/xx/"`
eval "mappedCmd=\${$var}"
if [ "x$mappedCmd" == "x" ]; then 
	error "can't find mapped command for '$cmd', exiting ..."
fi

info "running '$cmd' => '$mappedCmd' ..."


cmdline=($mappedCmd)
logline=($mappedCmd)

isCompiler=no
if [ "x$cmd" == "xcc" ] || [ "x$cmd" == "xgcc" ] || [ "x$cmd" == "xg++" ] || [ "x$cmd" == "xclang" ]; then
	isCompiler=yes
fi

isLinker=no
if [ "x$cmd" == "xld" ]; then
	isLinker=yes
fi


function addarg() {
	local arg=$1
	cmdline+=($arg)
	logline+=($arg)
}


# check if c pre processor is needed
if [ "x$cmd" == "xcpp" ]; then
	addarg "-E"
fi

# check if special brosx flags are needed
isLibbrosxInstalled=no
if [ -f $hostDir/include/libbrosx.h ]; then
	isLibbrosxInstalled=yes
fi

if [ "$isCompiler" == "yes" ] && [ "$isLibbrosxInstalled" == "yes" ]; then
	needsBrOsxCFlags=no
	needsBrOsxLdFlags=no

	for i in ${!args[@]};  do
		arg="${args[$i]}"
		# dont mess with autoconf calls
		if [[ $arg =~ ^.*conftest\..*$ ]] || [ "x$arg" == "x-D__GMP_WITHIN_GMP" ]; then
			needsBrOsxCFlags=no
			needsBrOsxLdFlags=no
			break
		fi
		# check for compile action
		if [[ $arg =~ ^(-I|-c).*$ ]] ; then
			needsBrOsxCFlags=yes
		fi
		# check for link action
		if [[ $arg =~ ^(-L|-Wl,).*$ ]] ; then
			needsBrOsxLdFlags=yes
		fi
	done
fi

if [ "$needsBrOsxCFlags" == "yes" ]; then
	addarg "-include"
	addarg "$hostDir/include/libbrosx.h"
fi

if [ "$needsBrOsxLdFlags" == "yes" ]; then	
	addarg "-L$hostDir/lib"
	addarg "-lbrosx"
fi

# filter args if necessary
for i in ${!args[@]};  do
	arg="${args[$i]}"
	info "- arg-$i: '$arg'"
	if [ "x$tcName" == "xxcode" ]; then
		# check for unsupported linker arguments
		if [[ $arg =~ ^-Wl,--version-script.*$ ]] || \
		   [[ $arg =~ ^-Wl,-soname.*$ ]] || \
		   [ "x$arg" == "x-Wl,libbz2.so.1.0" ] || \
		   [ "x$arg" == "x-Wl,--hash-style=both" ]; then
			info "--- skipping unsupported arg '$arg'"
			continue
		fi
		# check and filter out -MMD pre-processor flags
		if [[ $arg =~ ^-Wp.*$ ]]; then
			tmp=$arg
			arg=`echo $arg | sed "s#,\?-MMD,[^,]##"`
			info "--- patching -MMD arg '$tmp' -> '$arg'"
		fi
	fi

	# check for space in arg and wrap it in quotes
	if [[ "$arg" =~ \  ]]; then
		logline+=("\"$arg\"")
	else
		logline+=($arg)
	fi
	cmdline+=("$arg")
done

info "- executing '${logline[*]}' ..."
"${cmdline[@]}"
rc=$?

info "running '$cmd' ... done."

exit $rc

