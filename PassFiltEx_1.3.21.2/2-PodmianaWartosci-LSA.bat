@echo off
setlocal

REM Define variables for registry key and value
set "regKey=HKLM\SYSTEM\CurrentControlSet\Control\Lsa"
set "regValue=Notification Packages"
set "newValue=rassfm scecli PassFiltEx"

REM Check if the script is run with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: This script must be run as an administrator!
    exit /b 1
)

REM Backup the current value of the registry key
for /f "tokens=*" %%a in ('reg query "%regKey%" /v "%regValue%" 2^>nul') do (
    set "currentValue=%%a"
)

REM If the registry value exists, output its current value
if defined currentValue (
    echo Current value of "%regValue%" before change: %currentValue%
) else (
    echo "%regValue%" does not exist. It will be created.
)

REM Set the new value for the registry key
echo Setting registry key "%regKey%" value "%regValue%" to "%newValue%"...
reg add "%regKey%" /v "%regValue%" /t REG_MULTI_SZ /d "%newValue%" /f
if errorlevel 1 (
    echo Error: Failed to set the registry value. Please check your permissions or the command syntax.
    exit /b 2
) else (
    echo Successfully set "%regValue%" to "%newValue%".
	echo Zmiany wykonano prawidłowo.
)

endlocal
exit /b 0