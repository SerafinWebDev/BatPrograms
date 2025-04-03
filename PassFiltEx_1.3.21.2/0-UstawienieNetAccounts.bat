@echo off
setlocal

REM Define the commands to be executed
set "minPwdLen=12"
set "maxPwdAge=30"
set "uniquePw=3"

REM Check if the script is run with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: This script must be run as an administrator!
    exit /b 1
)

REM Set minimum password length
echo Setting minimum password length to %minPwdLen%...
NET ACCOUNTS /MINPWLEN:%minPwdLen%
if errorlevel 1 (
    echo Error: Failed to set minimum password length to %minPwdLen%. Please check your permissions or the command syntax.
    exit /b 2
) else (
    echo Successfully set minimum password length to %minPwdLen%.
	echo Zmiane minimalnej liczby znaków hasła wykonano prawidłowo.
)

REM Set maximum password age
echo Setting maximum password age to %maxPwdAge% days...
NET ACCOUNTS /MAXPWAGE:%maxPwdAge%
if errorlevel 1 (
    echo Error: Failed to set maximum password age to %maxPwdAge%. Please check your permissions or the command syntax.
    exit /b 3
) else (
    echo Successfully set maximum password age to %maxPwdAge% days.
	echo Czas zmiany hasła ustawiono prawidłowo.
)

REM Set the number of unique passwords required
echo Setting the number of unique passwords required to %uniquePw%...
NET ACCOUNTS /UNIQUEPW:%uniquePw%
if errorlevel 1 (
    echo Error: Failed to set unique password requirement to %uniquePw%. Please check your permissions or the command syntax.
    exit /b 4
) else (
    echo Successfully set unique password requirement to %uniquePw%.
	echo Zmiane unikalości hasła wykonano prawidłowo.
)




endlocal
exit /b 0