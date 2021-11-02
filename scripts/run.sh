#!/bin/bash


dthis=$(cd "$(dirname "$0")" && pwd)

executable=autossh
remoteport=17075
remote='rssh@gitlab'
dssh=$(cygpath -u 'd:\home\.ssh')


"$executable" -M0 \
    -oserveraliveinterval=60 \
    -oserveralivecountmax=1 \
    -oexitonforwardfailure=yes \
    -N -R "$remoteport:localhost:22" \
    -i "$dssh/id_rsa" \
    -ouserknownhostsfile="\"$dssh/known_hosts\"" \
    "$remote" \
    2>&1|while read -r;do
        printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$REPLY"
    done


