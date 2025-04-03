@echo off
setlocal

REM Define variables for the registry key and values
set "softwareRegKey=HKLM\SOFTWARE\PassFiltEx"

set "blacklistFileName=BlacklistFileName"
set "blacklistFileValue=PassFiltExBlacklist.txt"

set "tokenPercentageOfPassword=TokenPercentageOfPassword"
set "tokenPercentageValue=60"

set "minLower=MinLower"
set "minLowerValue=1"

set "minUpper=MinUpper"
set "minUpperValue=1"

set "minDigit=MinDigit"
set "minDigitValue=1"

set "minSpecial=MinSpecial"
set "minSpecialValue=1"

REM Check if the script is run with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: This script must be run as an administrator!
    exit /b 1
)

REM Create the registry key HKLM\SOFTWARE\PassFiltEx
echo Creating registry key "%softwareRegKey%"...
reg add "%softwareRegKey%" /f
if errorlevel 1 (
    echo Error: Failed to create the registry key "%softwareRegKey%". Please check your permissions or the command syntax.
    exit /b 2
) else (
    echo Successfully created the registry key "%softwareRegKey%".
)

REM Add the required values to the registry key
echo Adding values to "%softwareRegKey%"...

REM Add BlacklistFileName
reg add "%softwareRegKey%" /v "%blacklistFileName%" /t REG_SZ /d "%blacklistFileValue%" /f
if errorlevel 1 (
    echo Error: Failed to set value "%blacklistFileName%". Please check your permissions or the command syntax.
    exit /b 3
) else (
    echo Successfully set "%blacklistFileName%" to "%blacklistFileValue%".
)

REM Add TokenPercentageOfPassword
reg add "%softwareRegKey%" /v "%tokenPercentageOfPassword%" /t REG_DWORD /d %tokenPercentageValue% /f
if errorlevel 1 (
    echo Error: Failed to set value "%tokenPercentageOfPassword%". Please check your permissions or the command syntax.
    exit /b 4
) else (
    echo Successfully set "%tokenPercentageOfPassword%" to "%tokenPercentageValue%".
)

REM Add MinLower
reg add "%softwareRegKey%" /v "%minLower%" /t REG_DWORD /d %minLowerValue% /f
if errorlevel 1 (
    echo Error: Failed to set value "%minLower%". Please check your permissions or the command syntax.
    exit /b 5
) else (
    echo Successfully set "%minLower%" to "%minLowerValue%".
	echo Wykonano prawidłowo ustawienie minimum jednej małej litery.
)

REM Add MinUpper
reg add "%softwareRegKey%" /v "%minUpper%" /t REG_DWORD /d %minUpperValue% /f
if errorlevel 1 (
    echo Error: Failed to set value "%minUpper%". Please check your permissions or the command syntax.
    exit /b 6
) else (
    echo Successfully set "%minUpper%" to "%minUpperValue%".
	echo Wykonano prawidłowo ustawienie minimum jednej dużej litery.
)

REM Add MinDigit
reg add "%softwareRegKey%" /v "%minDigit%" /t REG_DWORD /d %minDigitValue% /f
if errorlevel 1 (
    echo Error: Failed to set value "%minDigit%". Please check your permissions or the command syntax.
    exit /b 7
) else (
    echo Successfully set "%minDigit%" to "%minDigitValue%".
	echo Wykonano prawidłowo ustawienie minimum jednej cyfry.
)

REM Add MinSpecial
reg add "%softwareRegKey%" /v "%minSpecial%" /t REG_DWORD /d %minSpecialValue% /f
if errorlevel 1 (
    echo Error: Failed to set value "%minSpecial%". Please check your permissions or the command syntax.
    exit /b 8
) else (
    echo Successfully set "%minSpecial%" to "%minSpecialValue%".
	echo Wykonano prawidłowo ustawienie minimum jednego znaku spec.
)

endlocal
exit /b 0