#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
# [ -z "${isnssm+x}" ]&&isnssm=t



_inspect(){
    "$dthis/scripts/inspect.sh" --inspect
    "$dthis/scripts/inspect.sh" --status
}

_install(){
    :
    #if [ "$isnssm" = t ];then
    if [ $# -eq 0 ];then
        "$dthis/scripts/win/install.bat"
    else
        "$dthis/scripts/cygwin/install.sh" --install "$@"
    fi
}

_remove(){
    :
    #if [ "$isnssm" = t ];then
    if [ $# -eq 0 ];then
        "$dthis/scripts/win/uninstall.bat"
    else
        "$dthis/scripts/cygwin/install.sh" --remove "$@"
    fi
}



_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --install [servicename]
	    $0 --remove [servicename]
	    $0 --inspect
	EPILOGUE
	    sudo bash -c './install.sh --remove'
	    ./install.sh --install          installs 1rssh (env.bat)
	    ./install.sh --install 3rssh    installs 3rssh (config)
	EOF
}

case $1 in
    --install)shift;_install "$@";;
    --remove)shift;_remove "$@";;
    --inspect)_inspect;;
    *)_usage;;
esac


