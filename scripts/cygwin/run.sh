#!/bin/bash


dthis=$(cd "$(dirname "$0")" && pwd)
droot="$(cd "$dthis/../.." && pwd)"
executable=autossh
remoteport=17075
remote='rssh@gitlab'
dssh=$(cygpath -u 'd:\home\.ssh')
fidentity=$(cygpath -u 'd:\home\.ssh\id_rsa')
source "$dthis/env.sh"
dssh=$(cygpath -u "$dssh")
fidentity=$(cygpath -u "$fidentity")


echo "$executable" -M0 \
    -oserveraliveinterval=60 \
    -oserveralivecountmax=1 \
    -oexitonforwardfailure=yes \
    -N -R "$remotebind$remoteport:localhost:$hostport" \
    -i"$fidentity" \
    -ouserknownhostsfile="\"$dssh/known_hosts\"" \
    "$remote" \
    2>&1|while read -r;do
        printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$REPLY"
    done


