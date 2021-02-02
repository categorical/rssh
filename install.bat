
@echo off

SET "thisdir=%~dp0"

SET "nssm=%thisdir%nssm.exe"
SET "run=%thisdir%run.bat"


SET servicename=rssh
CALL :installservice

PAUSE
GOTO :eof

:installservice
sc delete %servicename%
net stop %servicename%
"%nssm%" install %servicename% "%run%"
"%nssm%" start %servicename%


