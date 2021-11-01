#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"


_query(){
    "$dthis/scripts/query.sh" --query
}

_install(){
    :
    "$dthis/scripts/install.bat"
}

_uninstall(){
    :
    
    "$dthis/scripts/uninstall.bat"
}

_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --install
	    $0 --uninstall
	    $0 --query
	EOF
}

case $1 in
    --install)_install;;
    --uninstall)_uninstall;;
    --query)_query;;
    *)_usage;;
esac


