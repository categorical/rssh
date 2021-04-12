#!/bin/bash


dthis=$(cd "$(dirname "$0")" && pwd)

executable=autossh
remoteport=16009
remote='rssh@intermediate'
dssh=$(cygpath -u 'd:\home\.ssh')


"$executable" -M0 \
    -oserveraliveinterval=60 \
    -oserveralivecountmax=1 \
    -N -R "$remoteport:localhost:22" \
    -i "$dssh/id_rsa" \
    -ouserknownhostsfile="\"$dssh/known_hosts\"" \
    "$remote"


