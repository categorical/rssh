#!/bin/bash



dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/../.." && pwd)"
fenv="$droot/env.bat"
fconfig="$droot/config"


_sourcebatline(){
    local k v
    k="$(printf '%s' "$1"|sed 's/^SET "\([_a-z]*\)=\(.*\)"$/\1/')";k="${k#_}"
    v="$(printf '%s' "$1"|sed 's/^SET "\([_a-z]*\)=\(.*\)"$/\2/')"
    eval "$k='$v'"
}
_sourcebat(){
    [ -f "$1" ]||return 1
    while IFS= read -r;do
        case $REPLY in
            'SET '*)_sourcebatline "$REPLY";;
            *);;
        esac
    done < "$1"
};



_configvs(){
    local k1="$(_esed "$1")"
    IFS=$'\n' read -r -d $'\0' -a "$2" \
        < <(sed -n -e "s/^$k1\\s\\+//p" "$fconfig"|sed 's/\s*$//')
}
_configfield(){
    local k1="$(_esed "$1")"
    local k2="$(_esed "$2")"
    local k3="$(_esed "$3")"
    sed -n -e "/^$k1\\s\\+$k2/,\${/^\\s*$/q;s/^$k3\\s\\+//p}" "$fconfig"|sed -e 's/\s*$//'
}
_esed(){ printf '%s' "$1"|sed 's/[.[\*^$/]/\\&/g';}
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}


_setenv(){ 
    servicename="$1"
    _setenvconfig "$1" && return
    _setenvbat
}

_setenvbat(){
    _sourcebat "$fenv"||return 1
    _infof 'confs loaded: servicename: %s file: %s' "$servicename" "$fenv"
}

_setenvconfig(){
    if [ ! -f "$fconfig" ] \
        || [ -z "$1" ] \
        || ! grep 'servicename' "$fconfig"|grep "$1" 2>&1 >/dev/null;then
        _infof 'not found: servicename: %s file: %s' "$1" "$fconfig"
        return 1
    fi
    remote="$(_configfield 'servicename' "$1" 'remote')"
    remoteport="$(_configfield 'servicename' "$1" 'remoteport')"
    hostport="$(_configfield 'servicename' "$1" 'hostport')"
    remotebind="$(_configfield 'servicename' "$1" 'remotebind')"
    _infof 'confs loaded: servicename: %s file: %s' "$servicename" "$fconfig"
}

