#!/bin/bash



dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/.." && pwd)"
fenv="$droot/env.bat"



_sourcebat(){
    [ -f "$1" ]||return 1
    while IFS= read -r;do
        case $REPLY in
            'SET '*)_sourcebatline "$REPLY";;
            *);;
        esac
    done < "$fenv"
    #[ ! -f "$fenv" ]||servicename=$(sed -n 's/^SET "servicename=\([0-9a-z]*\)"$/\1/p' "$fenv")
}
_sourcebatline(){
    local k v
    k="$(printf '%s' "$1"|sed 's/^SET "\([_a-z]*\)=\(.*\)"$/\1/')";k="${k#_}"
    v="$(printf '%s' "$1"|sed 's/^SET "\([_a-z]*\)=\(.*\)"$/\2/')"
    eval "$k='$v'"
}


_sourcebat "$fenv"


