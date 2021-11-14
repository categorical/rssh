#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
# [ -z "${isnssm+x}" ]&&isnssm=t



_inspect(){
    "$dthis/scripts/inspect.sh" --inspect
    "$dthis/scripts/inspect.sh" --status
}

_install(){
    :
    if [ "$isnssm" = t ];then
        "$dthis/scripts/win/install.bat"
    else
        "$dthis/scripts/cygwin/install.sh" --install "$@"
    fi
}

_remove(){
    :
    if [ "$isnssm" = t ];then
        "$dthis/scripts/win/uninstall.bat"
    else
        "$dthis/scripts/cygwin/install.sh" --remove "$@"
    fi
}



_usage(){
    cat<<-EOF
	SYNOPSIS
	    [isnssm=t] $0 --install
	    [isnssm=t] $0 --remove
	    $0 --inspect
	EPILOGUE
	    sudo bash -c 'isnssm= ./install.sh --remove'
	    isnssm=t ./install.sh --install installs 1rssh (env.bat) using nssm
	    ./install.sh --install          installs 2rssh (env.bat) using cygrunsrv
	    ./install.sh --install 3rssh    installs 3rssh (config) using cygrunsrv
	EOF
}

case $1 in
    --install)shift;_install "$@";;
    --remove)shift;_remove "$@";;
    --inspect)_inspect;;
    *)_usage;;
esac


