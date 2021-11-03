#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/.." && pwd)"
dlog="$droot/log"
fexecutable="$dthis/run.sh"


servicename='2rssh'

_install(){
    :
    cygrunsrv -I "$servicename" \
        -p "$fexecutable" \
        -1 "$dlog/$servicename.stdout" \
        -2 "$dlog/$servicename.stderr"
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


