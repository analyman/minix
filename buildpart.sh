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
export OUTPUT_TOP="$MINIX_SOURCE/../obj.i386"


export BSHELL="/usr/bin/sh"
export BUILDSEED="MINIX-3.4.0"
export BUILD_lib="no"
export BUILD_tools="no"
export DESTDIR="$MINIX_SOURCE/../obj.i386/destdir.i386"
export MACHINE="i386"
export MACHINE_ARCH="i386"
export HOST_OSTYPE="$(uname -smr | sed 's/ /-/g')"
export MAKELEVEL="1"
export MAKEFLAGS=" -d e -m $MINIX_SOURCE/share/mk -j 1 -J 15,16 .MAKE.LEVEL.ENV=MAKELEVEL BUILD_lib=no BUILD_tools=no HOST_OSTYPE=${HOST_OSTYPE} MKOBJDIRS=yes NOPOSTINSTALL=1 _SRC_TOP_=$MINIX_SOURCE _SRC_TOP_OBJ_=$OUTPUT_TOP _THISDIR_=$_THISDIR_"
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


mkdir_on_makefile() 
{
    [ $# -eq 1 ] || (echo "require one argument";         exit 2)
    [ -d $1 ]    || (echo "direcotry '$1' doesn't exist"; exit 2)

    for dir in $(ls $1); do
        if [ -d "$1/$dir" ] && [ -f "$1/$dir/Makefile" ]; then
            mkdir -p "$OUTPUT_TOP/$1/$dir"
            [ ! $? -eq 0 ] && return 0

            mkdir_on_makefile "$1/$dir"
            if [ ! $? -eq 0 ]; then
                echo "mkdir_on_makefile() fail"
                exit 1
            fi
        fi
    done

    return 0
}

mkdir_on_makefile "$1"
[ ! $? -eq 0 ] && exit 1


cd $_THISDIR_ && \
    $OUTPUT_TOP/tooldir.${HOST_OSTYPE}/bin/nbmake dependall _THISDIR_= BUILD_tools=no BUILD_lib=no

