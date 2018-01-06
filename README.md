Buidroot OSX - Use Buildroot on OSX natively.  

# About Buildroot OSX (brosx)

With Buildroot OSX you can run a [Buildroot environmet](https://buildroot.org/) natively on your Apple OSX system.
You can have a cross compile environment directly on your Mac without beeing forced to wrap a Linux system first into a virtual machine.
There is not need to setup up a Linux container like Valgrind, Docker or VirtualBox. You can simply use your Mac development tools and file system as they are.

 This is achieved by 
 - preparing a clean build environment in a shell
 - wrapping the Xcode toolchain to cope with unknown compiler args
 - providing patches for host packages to make them compile on OSX
  
 Currently, the build creates an ISO system image with [Busybox](https://www.busybox.net) that can start from Qemu or VirtualBox.
   
 
# Prepare Build Environment

## Install required tools

The Buildroot make system expects some basic tools to be available as described in the ["Mandatoy packages"](https://buildroot.org/downloads/manual/manual.html#requirement-mandatory) section of the Buildroot "System Requirements". 

We need the following tools:
- autoconf
- automake
- awk
- bash
- bc
- binutils
- bzip2
- coreutils
- cpio
- diffstat
- diffutils
- dot
- file
- findutils
- getopt
- getconf
- git
- grep
- gzip
- libtool
- m4
- make
- patch
- perl
- python
- rsync
- sed
- tar
- unzip
- wget
- which

Most of the tools might be already available on your Mac, but we need the [GNU](https://www.gnu.org/software/software.en.html) based versions to reduce incompatibilities compared with a Linux system.
You can find them directly on the GNU ftp server at http://ftp.gnu.org/gnu/ or use any package manager to install them on your Mac.
In this guide we use [Homebrew - The missing package manager for macOS](https://brew.sh/) to fulfil this task.

## Prepare Build Environment

### Create Case Sensitive Filesystem

Since the Linux build requires a case sensitive file system, the native "Mac OS Extended" file system is not sufficient. We need to create an image that holds all build artefacts.

	hdiutil create -size 20g -type SPARSE -fs "Case-sensitive HFS+" -volname brosx brosx.sparseimage
	hdiutil attach brosx.sparseimage
	
In the build environemt we use the following directory structure. The names in braces refer to envirnment variables used in this guide.
	
	/Volumes/brosx        # mounted image root (BROSX_ROOT)
	├── buildroot         # home folder with buildroot git project is checked out (BROSX_HOME)
	└── toolchain         # links to the Xcode toolchain wrapper (BROSX_TOOLCHAIN)
	└── tools             # links to binaries of other required tools (BROSX_TOOLS)

After mounting the file system, we can enter the build root folder and clone the Buildroot OSX repository and checkout desired branch, e.g.
	
	cd /Volumes/brosx
	git clone git@github.com:generia/buildroot.git
	cd buildroot
	git checkout osx10
	

### Create Clean Shell Environment

Configure the build tools as they are installed on your Mac. There is a template at [`support/brosx/brosx.sh`](https://github.com/generia/buildroot/blob/osx10/support/brosx/brosx.sh) in the repository that helps to setup the environent. 
The configuration shown in that template was actually used to run the Busibox build.

	cp /Volumes/brosx/buildroot/support/brosx/brosx.sh /Volumes/brosx

The shell setup template is split into three parts. The first part defines basic folder variables. The second defines all variables that refer to the necessary tools installed on your Mac. 
These tools have been installed as described before. The second part contains some helper logic that configures the PATH and sets up links that the tools can be found properly.

The basic folder variables are
	
	BROSX_ROOT=/Volumes/brosx
	BROSX_HOME=$BROSX_ROOT/buildroot
	BROSX_TOOLS=$BROSX_ROOT/tools
	BROSX_TOOLCHAIN=$BROSX_ROOT/toolchain

The tool variables follow four certain patterns that are used by the setup logic.

	1. BROSX_<tool>_CMD=<tool-installation-file>
	2. BROSX_<tool-set>_HOME=<tool-set-installation-folder> 
	3. BROSX_<tool-set>_GHOME=<gnu-prefixed-tool-set-installation-folder> 
	3. BROSX_TOOLCHAIN_CMD_<tool>=<tool-installation-file> 

1. The first pattern defines single executables that reside somewhere on your Mac. The setup logic will create a link to each of them under `BROSX_TOOLS`.
2. The second pattern defines a folder that contains only executables forming a tool-set. The setup logic will add this folder to the `PATH`.
3. The third pattern defines a folder that contains gnu-tools that are installed with a "g" prefix. Since this is convention is not used in a Linux envirnment we strip the "g" prefix and link the base tool name in a folder under `$BROSX_ROOT/opt/<tool-set>/bin`. The tool-set folder with those links will be added to the `PATH`.   
4. The forth pattern configures the toolchain wrapper that is used to filter the calls to the Xcode toolchain. The setup logic links all tool to a single [`toolchain-wrapper-xcode.sh`](https://github.com/generia/buildroot/blob/osx10/support/brosx/toolchain-wrapper-xcode.sh). 
This wrapper determines the link target via the variable value. Before calling the actual compiler tool the arguments are parsed to filter out arguments not known to Xcode.

To aid debugging the toolchain wrapper supports logging. The logging can be turned on/off by defining a log file.

```
	BROSX_TOOLCHAIN_WRAPPER_LOG_DIR=$BROSX_HOME/ouput/build
	# leave log-file empty to turn logging off
	#BROSX_TOOLCHAIN_WRAPPER_LOG_FILE=
	BROSX_TOOLCHAIN_WRAPPER_LOG_FILE=$BROSX_TOOLCHAIN_WRAPPER_LOG_DIR/.toolchain-wrapper-xcode.log
```
 

After setting up all required locations in `brosx.sh`, you can start a clean shell and source the setup

	# NOTE: bash version 4.x required
	env -i bash --noprofile --norc 
	source /Volumes/brosx/brosx.sh

The build shell environment is now ready to use.


# Build System Image

TBD.

# Under the Hood

TBD.
