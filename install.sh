#!/bin/bash



_query(){
    :
}

_install(){
    :

}

_uninstall(){
    :
    
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
    *)_usage;;
esac


