
@echo off

SET "dthis=%~dp0"
FOR %%f IN ("%dthis%\..\") DO ^
SET "droot=%%~dpf"


SET "nssm=%droot%\vendor\nssm.exe"
SET "run=%dthis%run.bat"
SET "run=%dthis%run_echo.bat"
SET "run=%dthis%run_ssh.bat"
SET "dlog=%droot%log\"
SET "fenv=%droot%env.bat"
SET "servicename=0rssh"
IF exist "%fenv%" CALL "%fenv%"

RD /q /s "%dlog%" 2>nul
MKDIR "%dlog%" 2>nul

CALL :installservice

PAUSE
GOTO :eof

:installservice
sc delete %servicename%
net stop %servicename%
"%nssm%" install %servicename% "%run%"
"%nssm%" start %servicename%
"%nssm%" set %servicename% appstdout "%dlog%%servicename%.stdout"
"%nssm%" set %servicename% appstderr "%dlog%%servicename%.stderr"
"%nssm%" set %servicename% appexit default restart
"%nssm%" set %servicename% apprestartdelay 10000
"%nssm%" set %servicename% appthrottle 0
"%nssm%" set %servicename% start service_demand_start





