

@echo off
SET "thisdir=%~dp0"
SET "executable=d:\cygwin64\bin\autossh.exe"
SET "remoteport=16000"
SET "remote=root@gitlab"
SET "dssh=d:\home\.ssh\"

"%executable%" -M0 ^
    -o ServerAliveInterval=30 ^
    -o ServerAliveCountMax=1 ^
    -N -R %remoteport%:localhost:22 ^
    -i "%dssh%id_rsa" ^
    -o UserKnownHostsFile="""%dssh%known_hosts""" ^
    "%remote%"


::    -F "%dssh%config" ^


