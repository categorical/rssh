#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/../.." && pwd)"
dlog="$droot/log"
fexecutable="$dthis/run.sh"
source "$dthis/env.sh"
fconfig="$droot/config"

_install(){
    :
    cygrunsrv -I "$servicename" \
        -p "$fexecutable" \
        -1 "$dlog/$servicename.stdout" \
        -2 "$dlog/$servicename.stderr" \
        -e remotebind="$remotebind" \
        -e remoteport="$remoteport" \
        -e remote="$remote" \
        -e hostport="$hostport" \
        -e fidentity="$fidentity" \
        -e dssh="$dssh" \
        && _start
}
_installlist(){
    :
    declare -a vs
    _configvs "$fconfig" 'servicename' 'vs'
    for v in "${vs[@]}";do
        _infof '%s' "$v"
    done
}

_remove(){
    :
    cygrunsrv -R "$servicename"
}

_status(){
    :
    cygrunsrv --query "$servicename"
}
_start(){
    :
    cygrunsrv --start "$servicename"
}
_stop(){
    :
    cygrunsrv --stop "$servicename"
}
_list(){
    :
    cygrunsrv --list
}




_usage(){
    :
    cat<<-EOF
	    $0 --install
	    $0 --remove
	    $0 --status
	EOF
}


case $1 in
    --list)_list;;
    --*)shift;_setenv "$1"||{ _errorf 'not found: %s' "$1";exit 1;};;&
    --install)_install;;
    --remove)_remove;;
    --status)_status;;
    --start)_start;;
    --stop)_stop;;
    *)_usage;;
esac


