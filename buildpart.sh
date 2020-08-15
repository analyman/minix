#!/usr/bin/sh

usage() 
{
    cat <<EOF
usage:
       $0 <direcotry>
EOF
}

[ ! "$#" -eq "1" ] && usage && exit 2
[ ! -d "$1" ]      && usage && exit 2

[ "$1" = "." ] && 1=
export _THISDIR_="$1"
export MINIX_SOURCE="$(pwd)"


export BSHELL="/usr/bin/sh"
export BUILDSEED="MINIX-3.4.0"
export BUILD_lib="no"
export BUILD_tools="no"
export DESTDIR="$MINIX_SOURCE/../obj.i386/destdir.i386"
export MACHINE="i386"
export MACHINE_ARCH="i386"
export HOST_OSTYPE="$(uname -smr | sed 's/ /-/g')"
export MAKELEVEL="1"
export MAKEFLAGS=" -d e -m $MINIX_SOURCE/share/mk -j 1 -J 15,16 .MAKE.LEVEL.ENV=MAKELEVEL BUILD_lib=no BUILD_tools=no HOST_OSTYPE=${HOST_OSTYPE} MKOBJDIRS=yes NOPOSTINSTALL=1 _SRC_TOP_=$MINIX_SOURCE _SRC_TOP_OBJ_=$MINIX_SOURCE/../obj.i386 _THISDIR_=$_THISDIR_"
export MAKEOBJDIR="\${.CURDIR:C,^$MINIX_SOURCE,$MINIX_SOURCE/../obj.i386,}"
export MAKEWRAPPERMACHINE="i386"
export MKARZERO="yes"
export MKINSTALLBOOT="no"
export MKOBJDIRS="yes"
export MKUNPRIVED="yes"
export MKUPDATE="yes"
export MOTD_SHOWN="pam"
export NETBSDSRCDIR="$MINIX_SOURCE"
export NOPOSTINSTALL="1"
export RELEASEDIR="$MINIX_SOURCE/../obj.i386/releasedir"
export SCM_CHECK="true"
export TOOLDIR="$MINIX_SOURCE/../obj.i386/tooldir.${HOST_OSTYPE}"
export USETOOLS="yes"
export _SRC_TOP_="$MINIX_SOURCE"

cd $_THISDIR_ && ${MINIX_SOURCE}/../obj.i386/tooldir.${HOST_OSTYPE}/bin/nbmake dependall _THISDIR_= BUILD_tools=no BUILD_lib=no

