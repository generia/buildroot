# Usage: uname [OPTION]...
# Print certain system information.  With no OPTION, same as -s.
# 
#   -a, --all                print all information, in the following order,
#                              except omit -p and -i if unknown:
#   -s, --kernel-name        print the kernel name
#   -n, --nodename           print the network node hostname
#   -r, --kernel-release     print the kernel release
#   -v, --kernel-version     print the kernel version
#   -m, --machine            print the machine hardware name
#   -p, --processor          print the processor type (non-portable)
#   -i, --hardware-platform  print the hardware platform (non-portable)
#   -o, --operating-system   print the operating system
#       --help     display this help and exit
#       --version  output version information and exit

thisDir=`dirname $0`
cmd=`basename $0`
args=( "$@" )

logFile=$BROSX_TOOLCHAIN_WRAPPER_LOG_FILE
hostDir=$BROSX_HOME/output/host

BROSX_UNAME_WRAPPER_KERNEL_NAME=Linux
BROSX_UNAME_WRAPPER_OPERATING_SYSTEM=GNU/Linux

un=$BROSX_uname_WRAPPER_DELEGATE
targetBuild=no
if [ "x$BROSX_MAKE_ENV_TYPE" == "xtarget" ]; then
	targetBuild=yes
fi
tcName=uname

info() {
	if [ "x$logFile" != "x" ]; then
		if [ ! -f  "$logFile" ]; then
			local logDir=`dirname $logFile`
			mkdir -p $logDir
		fi
		echo "[$(date +"%T") - $tcName] $1" >> $logFile
	fi	
}

error() {
	echo "[$(date +"%T") - $tcName] $1"
	exit
}

hasAArg=no
hasSArg=no
hasNArg=no
hasRArg=no
hasVArg=no
hasMArg=no
hasPArg=no
hasIArg=no
hasOArg=no
hasHelpArg=no
hasVersionArg=no

hasArgs=no
logArgs=""
for i in ${!args[@]};  do
	hasArgs=yes
	arg="${args[$i]}"
	logArgs="$logArgs $arg"	
	# check for compile action
	if [ "$arg" == "-a" ] || [ "$arg" == "--all" ]; then
		hasAArg=yes
	fi
	if [ "$arg" == "-s" ] || [ "$arg" == "--kernel-name" ]; then
		hasSArg=yes
	fi
	if [ "$arg" == "-n" ] || [ "$arg" == "--nodename" ]; then
		hasNArg=yes
	fi
	if [ "$arg" == "-r" ] || [ "$arg" == "--kernel-release" ]; then
		hasRArg=yes
	fi
	if [ "$arg" == "-v" ] || [ "$arg" == "--kernel-version" ]; then
		hasVArg=yes
	fi
	if [ "$arg" == "-m" ] || [ "$arg" == "--machine" ]; then
		hasMArg=yes
	fi
	if [ "$arg" == "-p" ] || [ "$arg" == "--processor" ]; then
		hasPArg=yes
	fi
	if [ "$arg" == "-i" ] || [ "$arg" == "--hardware-platform" ]; then
		hasIArg=yes
	fi
	if [ "$arg" == "-o" ] || [ "$arg" == "--operating-system" ]; then
		hasOArg=yes
	fi
	if [ "$arg" == "--help" ]; then
		hasHelpArg=yes
	fi
	if [ "$arg" == "--version" ]; then
		hasVersionArg=yes
	fi
done

# check for default arg
if [ $hasArgs == no ]; then
	hasSArg=yes
fi

result=""
if [ $hasAArg == yes ]; then
	if [ $targetBuild == yes ]; then
		result=$"$BROSX_UNAME_WRAPPER_KERNEL_NAME `$un -n` `$un -r` `$un -v` `$un -m` `$un -p` `$un -i` $BROSX_UNAME_WRAPPER_OPERATING_SYSTEM" 
	else		
		result=`$un -a`
	fi
else
	sep=""
	if [ $hasSArg == yes ]; then
		if [ $targetBuild == yes ]; then
			result="$result$sep$BROSX_UNAME_WRAPPER_KERNEL_NAME"
		else		
			result="$result$sep`$un -s`"
		fi
		sep=" "
	fi 
	if [ $hasNArg == yes ]; then
		result="$result$sep`$un -n`"
		sep=" "
	fi 
	if [ $hasRArg == yes ]; then
		result="$result$sep`$un -r`"
		sep=" "
	fi 
	if [ $hasVArg == yes ]; then
		result="$result$sep`$un -v`"
		sep=" "
	fi 
	if [ $hasMArg == yes ]; then
		result="$result$sep`$un -m`"
		sep=" "
	fi 
	if [ $hasPArg == yes ]; then
		result="$result$sep`$un -p`"
		sep=" "
	fi 
	if [ $hasIArg == yes ]; then
		result="$result$sep`$un -i`"
		sep=" "
	fi 
	if [ $hasOArg == yes ]; then
		if [ $targetBuild == yes ]; then
			result="$result$sep$BROSX_UNAME_WRAPPER_OPERATING_SYSTEM"
		else		
			result="$result$sep`$un -o`"
		fi
		sep=" "
	fi 
fi
info "running 'uname $logArgs' -> '$result'"
info "- env: '`env | sort`'"

if [ $hasHelpArg == yes ]; then
	echo "brosx-uname-wrapper:"
	$un --help
elif [ $hasVersionArg == yes ]; then
	echo "brosx-uname-wrapper:"
	$un --version
else
	echo $result
fi
