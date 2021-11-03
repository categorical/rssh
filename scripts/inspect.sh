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

_servicenames(){
    [ -f "$fenv" ]||return 1
    IFS=$'\n' read -r -a "$1" -d $'\0' < \
        <(sed -n 's/^SET ".\?servicename=\([0-9a-z]*\)"$/\1/p' "$fenv")


}

_status(){
    :
    declare -a vs;_servicenames 'vs'
    for v in "${vs[@]}";do
        sc query "$v"
        sc qc "$v"
    done
}

_inspect(){
    declare -a vs;_servicenames 'vs'
    
    for v in "${vs[@]}";do
        _regentries "$v"
    done

}


_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --inspect
	    $0 --status
	EOF
}


case ${1:---inspect} in
    --inspect)_inspect;;
    --status)_status;;
    *)_usage;;
esac



