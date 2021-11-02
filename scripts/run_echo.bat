

@echo off
SET "dthis=%~dp0"
FOR %%f IN ("%dthis%\..\") DO ^
SET "droot=%%~dpf"
SET "fenv=%droot%env.bat"


ECHO %date% %time:~0,-3% %0

