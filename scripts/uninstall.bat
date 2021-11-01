
@echo off

SET "dthis=%~dp0"
FOR %%f IN ("%dthis%\..\") DO ^
SET "droot=%%~dpf"
SET "servicename=0rssh"
SET "fenv=%droot%env.bat"
IF exist "%fenv%" CALL "%fenv%"


CALL :uninstallservice

PAUSE
GOTO :eof

:uninstallservice
net stop %servicename%
sc delete %servicename%


