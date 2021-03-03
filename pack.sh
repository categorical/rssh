#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"

_pack(){
    local items=()
    items+=('nssm.exe')
    items+=('install.bat')
    items+=('run.bat')
    items+=('uninstall.bat')
 
    #local d="$dprogroot/GameServer/bin/Release/"
    local d="$dthis"
    local fdest=$(cygpath -w "$dthis/rssh.zip")
    [ -f "$fdest" ]&&(set -x;rm "$fdest")||:
    for v in "${items[@]}";do
        local f=$(cygpath -w "$d/$v")
        [ -f "$f" ]||return 1
        7z a "$fdest" "$f"
    done
    if [ -f "$fdest" ];then
        7z l "$fdest" \
            && _infof 'out: %s' "$fdest"
    else
        return 1
    fi
}


_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}



_pack






