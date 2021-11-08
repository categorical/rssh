#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/../.." && pwd)"
dlog="$droot/log"
fexecutable="$dthis/run.sh"
source "$dthis/env.sh"
fconfig="$droot/config"

_connect(){
    [ -f "$fconfig" ]||{ _errorf 'file not found: %s' "$fconfig" && exit 1;}
 
    local host="$(printf 'host %s' "$1")"
    grep "$host" "$fconfig" 2>&1 1>/dev/null||{ _errorf 'host not found: %s' "$1" && exit 1;}
    local s="$(_field "$host" 'server')"
    local u="$(_field "$host" 'username')"
    local p="$(_field "$host" 'password')"
    local d="$(_field "$host" 'database')"
    "$executable" -s "$s" -u "$u" -p "$p" -d "$d"
}


_install(){
    :
    cygrunsrv -I "$servicename" \
        -p "$fexecutable" \
        -1 "$dlog/$servicename.stdout" \
        -2 "$dlog/$servicename.stderr" \
        && _start
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
    --install)_install;;
    --remove)_remove;;
    --status)_status;;
    --start)_start;;
    --stop)_stop;;
    --list)_list;;
    *)_usage;;
esac


