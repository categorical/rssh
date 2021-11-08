#!/bin/bash



dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/../.." && pwd)"
fenv="$droot/env.bat"
fconfig="$droot/config"


_sourcebat(){
    [ -f "$1" ]||return 1
    while IFS= read -r;do
        case $REPLY in
            'SET '*)_sourcebatline "$REPLY";;
            *);;
        esac
    done < "$fenv"
}
_sourcebatline(){
    local k v
    k="$(printf '%s' "$1"|sed 's/^SET "\([_a-z]*\)=\(.*\)"$/\1/')";k="${k#_}"
    v="$(printf '%s' "$1"|sed 's/^SET "\([_a-z]*\)=\(.*\)"$/\2/')"
    eval "$k='$v'"
}


_sourcebat "$fenv"



_field(){
    local k1="$(_esed "$1")"
    local k2="$(_esed "$2")"
    local k3="$(_esed "$3")"
    sed -n -e "/^$k1\\s\+$k2/,\${/^\\s*$/q;s/^$k3//p}" "$fconfig"|tr -d '[:space:]'
}
_esed(){ printf '%s' "$1"|sed 's/[.[\*^$/]/\\&/g';}
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}










