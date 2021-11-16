#!/bin/bash



dthis="$(cd "$(dirname "$0")" && pwd)"
droot="$(cd "$dthis/.." && pwd)"
fenv="$droot/env.bat"
fconfig="$droot/config"

_regentries(){
    local servicename=$1 
    local k='HKLM\system\currentcontrolset\services\'$servicename
    reg query "$k"
    reg query "$k"'\parameters'
    reg query "$k"'\parameters\appexit'
    reg query "$k"'\parameters\environment'
}

_servicenames(){
    #[ -f "$fenv" ]||return 1
    #IFS=$'\n' read -r -a "$1" -d $'\0' < \
    #    <(sed -n 's/^SET ".\?servicename=\([0-9a-z]*\)"$/\1/p' "$fenv")
    declare -a _vs;
    if [ -f "$fenv" ];then
        while IFS= read -r -d $'\n';do
            _vs+=("$REPLY")
        done < <(sed -n 's/^SET ".\?servicename=\([0-9a-z]*\)"$/\1/p' "$fenv")
    fi
    if [ -f "$fconfig" ];then
        while IFS= read -r -d $'\n';do
            _vs+=("$REPLY")
        done < <(sed -n 's/^servicename\s\+//p' "$fconfig"|sed 's/\s*$//')
    fi
    
    mapfile -t -d $'\0' "$1" < \
        <(for _v in "${_vs[@]}";do printf '%s\0' "$_v";done)
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
    #declare -p vs
    for v in "${vs[@]}";do
        :
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



