@echo off

setlocal

set Q_CMD=q
set OLDPWD=%cd%
set MAIN_SCRIPT_DIR=%~dp0\src\q
set PAUSE_ON_END=true

rem Move user into directory of the q files
cd %MAIN_SCRIPT_DIR%

rem Starting main.q
echo "Starting main.q . . ."

%Q_CMD% "main.q"

rem Return user to previous directory they were in
cd %OLDPWD%

if %PAUSE_ON_END%==true (
    pause
)
