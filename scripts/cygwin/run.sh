#!/bin/bash


dthis=$(cd "$(dirname "$0")" && pwd)
droot="$(cd "$dthis/../.." && pwd)"
executable=autossh


remoteport=${remoteport:-17075}
remote=${remote:-'rssh@intermediate'}
dssh=${dssh:-'d:\home\.ssh'}
fidentity=${fidentity:-'d:\home\.ssh\id_rsa'}
hostport=${hostport:-22}

echo "$executable" -M0 \
    -oserveraliveinterval=60 \
    -oserveralivecountmax=1 \
    -oexitonforwardfailure=yes \
    -N -R "$remoteport:localhost:$hostport" \
    -i"$(cygpath -u "$fidentity")" \
    -ouserknownhostsfile="\"$(cygpath -u "$dssh")/known_hosts\"" \
    "$remote" \
    2>&1|while read -r;do
        printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$REPLY"
    done


