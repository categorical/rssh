

@echo off
SET "thisdir=%~dp0"
SET "executable=d:\cygwin64\bin\autossh.exe"
SET "remoteport=17071"
SET "remote=rssh@intermediate"
SET "dssh=d:\home\.ssh\"


ECHO|SET /p="%date% %time:~0,-3% " 1>&2
"%executable%" -M0 ^
    -o ServerAliveInterval=30 ^
    -o ServerAliveCountMax=1 ^
    -o exitonforwardfailure=yes ^
    -N -R %remoteport%:localhost:22 ^
    -i "%dssh%id_rsa" ^
    -o UserKnownHostsFile="""%dssh%known_hosts""" ^
    "%remote%"


::    -F "%dssh%config" ^


