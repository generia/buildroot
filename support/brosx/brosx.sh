#!/bin/bash

# basic root folders
BROSX_ROOT=/Volumes/brosx
BROSX_HOME=$BROSX_ROOT/buildroot
BROSX_TOOLS=$BROSX_ROOT/tools
BROSX_TOOLCHAIN=$BROSX_ROOT/toolchain

# locale settings
BROSX_LOCALE=en_US.UTF-8

######################### configure tool path according to local installation #########################

# tool-commands (*_CMD), tool-sets (*_HOME) and gnu-prefixed tool-sets (*_GHOME)
BROSX_AUTOCONF_HOME=/usr/local/Cellar/autoconf/2.69/bin
BROSX_AUTOMAKE_HOME=/usr/local/Cellar/automake/1.15.1/bin
BROSX_awk_CMD=/usr/local/Cellar/gawk/4.1.1/bin/gawk
BROSX_bash_CMD=/usr/local/Cellar/bash/4.4.12/bin/bash
BROSX_bc_CMD=/usr/bin/bc
BROSX_BINUTILS_GHOME=/usr/local/Cellar/binutils/2.29.1/bin
BROSX_BZIP2_HOME=/usr/local/Cellar/bzip2/1.0.6_1/bin
BROSX_COREUTILS_GHOME=/usr/local/Cellar/coreutils/8.23_1/bin
BROSX_cpio_CMD=/usr/bin/cpio
BROSX_diffstat_CMD=/usr/local/Cellar/diffstat/1.61/bin/diffstat
BROSX_DIFFUTILS_HOME=/usr/local/Cellar/diffutils/3.6/bin
BROSX_dot_CMD=/usr/local/bin/dot
BROSX_file_CMD=/usr/bin/file
BROSX_FINDUTILS_GHOME=/usr/local/Cellar/findutils/4.6.0/bin
BROSX_getopt_CMD=/usr/local/Cellar/gnu-getopt/1.1.6/bin/getopt
BROSX_getconf_CMD=/usr/bin/getconf
BROSX_git_CMD=/usr/local/Cellar/git/2.15.1_1/bin/git
BROSX_GREP_HOME=/usr/local/Cellar/grep/2.21/bin
BROSX_gzip_CMD=/usr/bin/gzip
BROSX_LIBTOOL_GHOME=/usr/local/Cellar/libtool/2.4.6_1/bin
BROSX_glibtoolize_CMD=$BROSX_LIBTOOL_GHOME/glibtoolize # needed by fakeroot
BROSX_m4_CMD=$BROSX_HOME/output/host/bin/m4
BROSX_make_CMD=/opt/local/bin/gmake
BROSX_patch_CMD=/usr/local/Cellar/gpatch/2.7.5/bin/patch
BROSX_perl_CMD=/opt/local/bin/perl5.22
BROSX_python_CMD=/usr/bin/python
BROSX_rsync_CMD=/usr/local/Cellar/rsync/3.1.2/bin/rsync
BROSX_sed_CMD=/usr/local/Cellar/gnu-sed/4.2.2/bin/gsed
BROSX_sh_CMD=$BROSX_bash_CMD
BROSX_tar_CMD=/usr/local/Cellar/gnu-tar/1.30/bin/gtar
BROSX_unzip_CMD=/usr/local/Cellar/unzip/6.0_3/bin/unzip 
BROSX_wget_CMD=/usr/local/Cellar/wget/1.16.1/bin/wget
BROSX_which_CMD=/usr/bin/which

# convenience commands not strictly needed in the build
BROSX_less_CMD=/usr/bin/less
BROSX_ssh_CMD=/usr/bin/ssh
BROSX_vi_CMD=/usr/bin/vi

# qemu
BROSX_sysctl_CMD=/usr/sbin/sysctl
BROSX_pod2man_CMD=/opt/local/bin/pod2man

# host-e2fsprogs
BROSX_Makeinfo_CMD=/opt/local/bin/Makeinfo 
BROSX_texi2dvi_CMD=/opt/local/bin/texi2dvi

# linux
BROSX_hostname_CMD=/bin/hostname

# cmake
BROSX_ps_CMD=/bin/ps

# host-python3
BROSX_sw_vers_CMD=/usr/bin/sw_vers

# host toolchain
BROSX_TOOLCHAIN_CMD_cc=/usr/bin/cc
BROSX_TOOLCHAIN_CMD_gcc=/usr/bin/gcc
BROSX_TOOLCHAIN_CMD_gxx=/usr/bin/g++ 
BROSX_TOOLCHAIN_CMD_cxx=/usr/bin/c++ 
BROSX_TOOLCHAIN_CMD_cpp=/usr/bin/cpp 
BROSX_TOOLCHAIN_CMD_clang=/usr/bin/clang
BROSX_TOOLCHAIN_CMD_as=/usr/bin/as
BROSX_TOOLCHAIN_CMD_ld=/usr/bin/ld 
BROSX_TOOLCHAIN_CMD_nm=/usr/bin/nm 
BROSX_TOOLCHAIN_CMD_ar=/usr/bin/ar
BROSX_TOOLCHAIN_CMD_strip=/usr/bin/strip 
BROSX_TOOLCHAIN_CMD_ranlib=/usr/bin/ranlib 
BROSX_TOOLCHAIN_CMD_objcopy=/usr/bin/objcopy 
BROSX_TOOLCHAIN_CMD_objdump=/usr/bin/objdump 
BROSX_TOOLCHAIN_CMD_readelf=/usr/bin/readelf 
BROSX_TOOLCHAIN_CMD_xcrun=/usr/bin/xcrun 
BROSX_TOOLCHAIN_CMD_Rez=/usr/bin/xcrun 
BROSX_TOOLCHAIN_CMD_SetFile=/usr/bin/xcrun 

# toolchain wrapper logging
BROSX_TOOLCHAIN_WRAPPER_LOG_DIR=$BROSX_HOME/output/build
# leave log-file empty to turn logging off
#BROSX_TOOLCHAIN_WRAPPER_LOG_FILE=
BROSX_TOOLCHAIN_WRAPPER_LOG_FILE=$BROSX_TOOLCHAIN_WRAPPER_LOG_DIR/.toolchain-wrapper-xcode.log
 
######################### no changes should be necessary below #########################

# setup shell helper
set +h
umask 002
TERM=xterm-256color
LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"
PS1="\[\e[0;32m\]brosx\[\e[0m\]\[\e[1;32m\]@\[\e[0;32m\]\h\[\e[1;32m\]:\[\e[0;37m\]\w\[\e[0m\]$ " 

# ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'

# parse variable pattern types
cmds=""
cmdHomes=""
cmdHGhomes=""
cmdToolchain=""

for var in ${!BROSX_*}; do 
	name=`echo $var | sed "s/BROSX_\(.*\)_.*$/\1/"`
	if [ $name == TOOLCHAIN ]; then
		tool=`echo $var | sed "s/BROSX_\([^_]*\)_CMD_\([^_]*\)/\2/"`
		if [ "x$tool" != "x$var" ]; then	
			cmdToolchain="$cmdToolchain $tool"
		fi
	else
		type=`echo $var | sed "s/BROSX_\(.*\)_\([^_]*\)$/\2/"`
		case $type in
		    CMD )
		        cmds="$cmds $name"
		        ;;
		    HOME )
		        cmdHomes="$cmdHomes $name"
		        ;;
		    GHOME )
		        cmdGhomes="$cmdGhomes $name"
		        ;;
		esac
	fi
done 

# helper functions
function installLink() { 
	cmdPath=$1
	cmdLink=$2
	envVar=$3
	if [ ! -e $cmdLink ]; then 		
		echo "- installing $envVar: link '$cmdLink' -> '$cmdPath'";
		ln -s -f $cmdPath $cmdLink;
	fi 
}

function linkGnuTool() { 
	srcDir=$1
	dstDir=$2
	envVar=$3
	mkdir -p $dstDir 
	pushd $srcDir 2>&1 >/dev/null
	for gCmd in `ls`; do  
		cmd=${gCmd#g}
		installLink $srcDir/$gCmd $dstDir/$cmd $envVar
	done
	popd 2>&1 >/dev/null
}

# setup logic for tools and tool-sets
BROSX_TOOLS_BIN=$BROSX_TOOLS/bin
BROSX_PATH=$BROSX_TOOLS_BIN

# link simple commands
mkdir -p $BROSX_TOOLS_BIN
for cmd in $cmds; do
	var=BROSX_${cmd}_CMD
	eval "cmdPath=\${$var}"
	cmdLink=$BROSX_TOOLS_BIN/${cmd}
	installLink $cmdPath $cmdLink $var
done

# add command sets to path
for home in $cmdHomes; do
	var=BROSX_${home}_HOME
	eval "homePath=\${$var}"
	BROSX_PATH=$BROSX_PATH:$homePath
done

# link and add gnu command sets to path
for ghome in $cmdGhomes; do
	var=BROSX_${ghome}_GHOME
	eval "ghomePath=\${$var}"
	dir=$BROSX_TOOLS/${ghome,,}/bin
	mkdir -p $dir
	linkGnuTool $ghomePath $dir $var
	BROSX_PATH=$BROSX_PATH:$dir
done


# setup toolchain wrapper and link toolchain commands
BROSX_PATH=$BROSX_TOOLCHAIN/bin:$BROSX_PATH
BROSX_TOOLCHAIN_WRAPPER=$BROSX_HOME/support/brosx/toolchain-wrapper-xcode.sh
mkdir -p $BROSX_TOOLCHAIN/bin
mkdir -p $BROSX_TOOLCHAIN_WRAPPER_LOG_DIR
for tool in $cmdToolchain; do
	var=BROSX_TOOLCHAIN_${tool}
	cmd=`echo $tool | sed "s/xx/++/"`
	cmdLink=$BROSX_TOOLCHAIN/bin/${cmd}
	mkdir -p $dir
	installLink $BROSX_TOOLCHAIN_WRAPPER $cmdLink $var
done

PATH=$BROSX_PATH

export LC_ALL=$BROSX_LOCALE
export LANG=$BROSX_LOCALE
export LANGUAGE=$BROSX_LOCALE

export TERM LS_COLORS PS1 M4 PATH BROSX_ROOT BROSX_HOME BROSX_TOOLS ${!BROSX_TOOLCHAIN_*}

#
# patch creation helper
#
# usage:
#    diffPackage <tarName> <pkgName> <outName> <patchName> <files>
#
function diffPackage() {
	local tarName=$1
	local pkgName=$2
	local outName=$3
	local patchName=$4
	local files=$5

	echo "This is brosx 'diffPackage' tool ..."
	echo "- tarName: '$tarName'"
	echo "- pkgName: '$pkgName'"
	echo "- outName: '$outName'"
	echo "- patchName: '$patchName'"
	echo "-"

	local brHome=$BROSX_HOME
	local dlDir=$brHome/dl
	local tarFile=$dlDir/$tarName
	local pkgVersion=`echo $tarName | sed "s/\(.*\)[\.-_]src\(\..*\)/\1\2/" | sed "s/.*-\([^-]*\)\.tar\..*/\1/" | sed "s/v//"`
	
	local workDir=$dlDir/.diffPackage
	mkdir -p $workDir
	
	echo "- extracting tar-file '$tarFile' ..."
	tar -xf $tarFile -C $workDir
		
	local tarDir=$workDir/`ls $workDir`
	
	local outDir=$brHome/output/build/$outName-$pkgVersion
	local srcDir=""
	local srcPath="package fs boot board"
	for dir in $srcPath; do
		if [ -d $brHome/$dir/$pkgName ]; then
			srcDir=$brHome/$dir/$pkgName
			break
		fi
	done
	if [ "x$pkgName" == "xlinux" ]; then
		srcDir=$brHome/$pkgName
	fi
	
	local patchFileName="9999-brosx-$4"
	local patchFile=$srcDir/$patchFileName.patch
	if [ -d $srcDir/$pkgVersion ]; then
		 patchFile=$srcDir/$pkgVersion/$patchFileName.patch
	fi
	echo "- diffing folders '$tarDir' -> '$outDir' ..."
	echo "Patch created by brosx \"diffPackage\" tool" > $patchFile
	echo "" >> $patchFile
	echo "usage:" >> $patchFile
	echo "    diffPackage <tarName> <pkgName> <outName> <patchName> <files>" >> $patchFile
	echo "" >> $patchFile
	echo "actual:" >> $patchFile
	echo "    diffPackage \"$tarName\" \"$pkgName\" \"$outName\" \"$patchName\" \"\\" >> $patchFile
	for file in $files; do
	echo "        $file \\" >> $patchFile
	done
	echo "    \";" >> $patchFile
	echo "" >> $patchFile
	echo "" >> $patchFile
	for file in $files; do
		local srcFile=$tarDir/$file
		local outFile=$outDir/$file
		
		echo "- diffing files '$srcFile' -> '$outFile' ..."
		echo "===============================================================================" >> $patchFile
		diff -u $srcFile $outFile | sed "s|--- $tarDir|--- a|" | sed "s|+++ $outDir|+++ b|"  >> $patchFile
	done
	
	echo "- reporting diffstats for patch-file '$patchFile' ..."
	diffstat $patchFile
	
	echo "- removing work-directory '$workDir' ..."
	rm -Rf $workDir
	echo "done."
}

echo "brosx environment setup done."