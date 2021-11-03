#!/bin/bash

dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/.." && pwd)"
dstaging="$droot/staging";[ -d "$dstaging" ]||mkdir "$dstaging"


_pack(){
    local items=()
    items+=('vendor/nssm.exe')
    items+=('scripts/install.bat')
    items+=('scripts/run.bat')
    items+=('scripts/uninstall.bat')
 
    local d="$droot"
    local fdest=$(cygpath -w "$dstaging/rssh.zip")
    [ -f "$fdest" ]&&(set -x;rm "$fdest")||:
    (cd "$d" && for v in "${items[@]}";do
        #local f=$(cygpath -w "$d/$v")
        local f="$v"
        [ -f "$f" ]||return 1
        7z a "$fdest" "$f"
    done)
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






