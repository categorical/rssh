#!/bin/bash



servicename='rssh'

_query(){
    
    local k='HKLM\system\currentcontrolset\services\'$servicename
    reg query "$k"


}


_usage(){
    cat<<-EOF
	SYNOPSIS
	    $0 --query
	EOF
}


case $1 in
    --query)_query;;
    *)_usage;;
esac



