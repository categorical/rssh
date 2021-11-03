

@echo off
SET "dthis=%~dp0"
FOR %%f IN ("%dthis%\..\..\") DO ^
SET "droot=%%~dpf"
SET "fenv=%droot%env.bat"
SET "executable=d:\cygwin64\bin\ssh.exe"
SET "remoteport=17071"
SET "remote=rssh@intermediate"
SET "dssh=d:\home\.ssh\"
SET "fidentity=%dssh%id_rsa"
IF exist "%fenv%" CALL "%fenv%"

ECHO|SET /p="%date% %time:~0,-3% " 1>&2
"%executable%" ^
    -o ServerAliveInterval=30 ^
    -o ServerAliveCountMax=1 ^
    -o exitonforwardfailure=yes ^
    -N -R %remoteport%:localhost:22 ^
    -i "%fidentity%" ^
    -o UserKnownHostsFile="""%dssh%known_hosts""" ^
    "%remote%"


::    -F "%dssh%config" ^


