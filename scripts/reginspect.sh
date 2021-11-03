#!/bin/bash



dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/.." && pwd)"
fenv="$droot/env.bat"


_regentries(){
    local servicename=$1 
    local k='HKLM\system\currentcontrolset\services\'$servicename
    reg query "$k"
    reg query "$k"'\parameters'
    reg query "$k"'\parameters\appexit'
}
_inspect(){
    [ -f "$fenv" ]||return 1
    declare -a vs
    IFS=$'\n' read -r -a vs -d $'\0' < \
        <(sed -n 's/^SET ".\?servicename=\([0-9a-z]*\)"$/\1/p' "$fenv")

    for v in "${vs[@]}";do
        _regentries "$v"
    done

}


_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --inspect
	EOF
}


case ${1:---inspect} in
    --inspect)_inspect;;
    *)_usage;;
esac



