#!/bin/sh
#
# install-after.sh -- Custom installation
#
# The script will receive arguments:
#
#    $ install-after.sh .inst <install-dir> <PKG> <VER> <caller-prg>
#
# This script is run after [install] command. NOTE: Echo all messages
# with ">> " prefix".

PATH="/sbin:/usr/sbin/:/bin:/usr/bin:/usr/X11R6/bin"
LC_ALL="C"

set -e

Cmd()
{
    echo "$@"
    [ "$test" ] && return
    "$@"
}

Main()
{
    root=${1:-".inst"}
    pkg=$2
    ver=$3
    caller=$4

    if [ ! "$root"  ] || [ ! -d "$root" ]; then
        echo "$0: [ERROR] In $(pwd) no such directory: '$root'" >&2
        return 1
    fi

    root=$(echo $root | sed 's,/$,,')  # Delete trailing slash
    bindir=$root/usr/bin
    sharedir=$root/usr/share
    libdir=$root/usr/lib
    emacsdir=$sharedir/emacs/site-lisp
    mandir=$sharedir/man/man1

    # docdir=$(cd $root/usr/share/doc/[a-zA-Z]*-*[0-9] && pwd)
    docpkg=$(cd $root/usr/share/doc/[a-z]*[a-zA-Z] && pwd)

    #[ "$docdir" ] || return 0
    [ "$docpkg" ] || return 0

    echo ">> Deleting irrelevant examples/"
    Cmd rm -rf $docpkg/examples $docpkg/README.newscripts

}

Main "$@"

# End of file
