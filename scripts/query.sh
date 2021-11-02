#!/bin/bash



dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/.." && pwd)"
fenv="$droot/env.bat"
servicename='0rssh'

[ ! -f "$fenv" ]||servicename=$(sed -n 's/^SET "servicename=\([0-9a-z]*\)"$/\1/p' "$fenv")


_query(){
    
    local k='HKLM\system\currentcontrolset\services\'$servicename
    reg query "$k"

    reg query "$k"'\parameters'
    reg query "$k"'\parameters\appexit'

}


_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --query
	EOF
}


case ${1:---query} in
    --query)_query;;
    *)_usage;;
esac



