#!/bin/bash



dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/../.." && pwd)"
fenv="$droot/env.bat"
fconfig="$droot/config"
_filecache212a0391=

_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_esed(){ printf '%s' "$1"|sed 's/[.[\*^$/]/\\&/g';}

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


_filecachek(){
    local f="$1"
    printf '_filecache%s' "$(printf "$f"|md5sum|head -c8)"
}
_filecacheset(){
    local f="$1"
    local k="$(_filecachek "$f")"
    local v="$(cat "$f")"
    eval "$k="'"$v"'
}

_filecache(){
    local f="$1"
    local k="$(_filecachek "$f")"
    
    #local v="$(eval "printf '%s' \"\$$k\"")"
    local v="${!k}"
    printf '%s' "$v"
}

_configvs(){
    local f="$1"
    local k1="$(_esed "$2")"
    local _vs="$3"
    IFS=$'\n' read -r -d $'\0' -a "$_vs" \
        < <(sed -n -e "s/^$k1\\s\\+//p" "$f"|sed 's/\s*$//')
}
_configfield(){
    local f="$1"
    local k1="$(_esed "$2")"
    local k2="$(_esed "$3")"
    local k3="$(_esed "$4")"

    #sed -n -e "/^$k1\\s\\+$k2\\s*$/,\${/^\\s*$/q;s/^$k3\\s\\+//p}" < <(_filecache "$f")|sed -e 's/\s*$//'
    sed -n -e "/^$k1\\s\\+$k2\\s*$/,\${/^\\s*$/q;s/^$k3\\s\\+//p}" "$f"|sed -e 's/\s*$//'
}


_setenv(){ 
    servicename="$1"
    _filecacheset "$fconfig"
    _setenvconfig "$1" && return
    _setenvbat
}

_setenvbat(){
    _sourcebat "$fenv"||return 1
    _infof 'servicename: %s config: %s' "$servicename" "$fenv"
}

_setenvconfig(){
    local k1='servicename'
    if [ ! -f "$fconfig" ] \
        || [ -z "$1" ] \
        || [ -z "$(_configfield "$fconfig" "$k1" "$1" 'servicename')" ];then
        return 1
    fi
    local t0="$(date '+%s%N'|head -c13)"
    remote="$(_configfield "$fconfig" "$k1" "$1" 'remote')"
    remoteport="$(_configfield "$fconfig" "$k1" "$1" 'remoteport')"
    hostport="$(_configfield "$fconfig" "$k1" "$1" 'hostport')"
    remotebind="$(_configfield "$fconfig" "$k1" "$1" 'remotebind')"
    _infof 'servicename: %s config: %s' "$servicename" "$fconfig"
    local t1="$(date '+%s%N'|head -c13)"
    _infof 'elapsed: %d ms' $(($t1-$t0))
}

