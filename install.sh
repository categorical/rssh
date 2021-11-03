#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
[ -z "${isnssm+x}" ]&&isnssm=t


_inspect(){
    "$dthis/scripts/reginspect.sh"
}

_install(){
    :
    if [ "$isnssm" = t ];then
        "$dthis/scripts/install.bat"
    else
        "$dthis/scripts/install.sh" --install
    fi
}

_remove(){
    :
    if [ "$isnssm" = t ];then
        "$dthis/scripts/uninstall.bat"
    else
        "$dthis/scripts/install.sh" --remove
    fi
}



_usage(){
    cat<<-EOF
	SYNOPSIS
	    [isnssm=] $0 --install
	    [isnssm=] $0 --remove
	    $0 --query
	EOF
}

case $1 in
    --install)_install;;
    --remove)_remove;;
    --inspect)_inspect;;
    *)_usage;;
esac


