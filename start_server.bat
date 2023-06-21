@echo off

setlocal

rem This script takes the port of the server as an argument, though a default is specified if one isn't passed

set Q_CMD=q
set OLDPWD=%cd%
set DEFAULT_PORT=25565
set MAIN_SCRIPT_DIR=%~dp0\src\q
set PAUSE_ON_END=true

rem Setting port
if "%~1"=="" (
    set PORT=%DEFAULT_PORT%
) else (
    set PORT=%~1
)

rem Move user into directory of the q files
cd %MAIN_SCRIPT_DIR%

rem Starting server.q
echo "Starting server.q . . ."

%Q_CMD% "server.q" -p %PORT%

rem Return user to previous directory they were in
cd %OLDPWD%

if %PAUSE_ON_END%==true (
    pause
)
