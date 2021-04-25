
@echo off

SET "thisdir=%~dp0"

SET "nssm=%thisdir%nssm.exe"
SET "run=%thisdir%run.bat"
SET "dlog=%thisdir%log\"

RD /q /s "%dlog%" 2>nul
MKDIR "%dlog%" 2>nul

SET servicename=rssh
CALL :installservice

PAUSE
GOTO :eof

:installservice
sc delete %servicename%
net stop %servicename%
"%nssm%" install %servicename% "%run%"
"%nssm%" start %servicename%
"%nssm%" set %servicename% appstdout "%dlog%stdout"
"%nssm%" set %servicename% appstderr "%dlog%stderr"
"%nssm%" set %servicename% appexit default restart
"%nssm%" set %servicename% apprestartdelay 10000
"%nssm%" set %servicename% appthrottle 0
"%nssm%" set %servicename% start service_demand_start





