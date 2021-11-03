#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
[ -z "${isnssm+x}" ]&&isnssm=t


_inspect(){
    "$dthis/scripts/inspect.sh" --inspect
    "$dthis/scripts/inspect.sh" --status
}

_install(){
    :
    if [ "$isnssm" = t ];then
        "$dthis/scripts/win/install.bat"
    else
        "$dthis/scripts/cygwin/install.sh" --install
    fi
}

_remove(){
    :
    if [ "$isnssm" = t ];then
        "$dthis/scripts/win/uninstall.bat"
    else
        "$dthis/scripts/cygwin/install.sh" --remove
    fi
}



_usage(){
    cat<<-EOF
	SYNOPSIS
	    [isnssm=] $0 --install
	    [isnssm=] $0 --remove
	    $0 --inspect
	EPILOGUE
	    sudo bash -c 'isnssm= ./install.sh --remove'
	    ./install.sh --install          uses nssm
	    isnssm=t ./install.sh --install uses nssm
	    isnssm= ./install.sh --install  uses cygrunsrv
	EOF
}

case $1 in
    --install)_install;;
    --remove)_remove;;
    --inspect)_inspect;;
    *)_usage;;
esac


