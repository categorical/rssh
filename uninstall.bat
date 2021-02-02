
@echo off

SET "thisdir=%~dp0"

SET servicename=rssh
CALL :uninstallservice

PAUSE
GOTO :eof

:uninstallservice
net stop %servicename%
sc delete %servicename%


