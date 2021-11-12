#!/bin/bash


dthis=$(cd "$(dirname "$0")" && pwd)
droot="$(cd "$dthis/../.." && pwd)"
executable=autossh

hostport=${hostport:-22}
remotebind=${remotebind:-127.0.0.1}
remoteport=${remoteport:-17075}
remote=${remote:-'rssh@intermediate'}
fidentity=${fidentity:-'d:\home\.ssh\id_rsa'}
dssh=${dssh:-'d:\home\.ssh'}

echo "$executable" -M0 \
    -oserveraliveinterval=60 \
    -oserveralivecountmax=1 \
    -oexitonforwardfailure=yes \
    -N -R "$remotebind:$remoteport:localhost:$hostport" \
    -i"$(cygpath -u "$fidentity")" \
    -ouserknownhostsfile="\"$(cygpath -u "$dssh")/known_hosts\"" \
    "$remote" \
    2>&1|while read -r;do
        printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$REPLY"
    done


