#!/bin/bash



servicename='1rssh'

_query(){
    
    local k='HKLM\system\currentcontrolset\services\'$servicename
    reg query "$k"

    reg query "$k"'\parameters'

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



