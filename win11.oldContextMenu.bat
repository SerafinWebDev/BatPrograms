@echo off
setlocal

REM Define the registry key
set "regKey=HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

REM Add the registry entry
reg.exe add "%regKey%" /f /ve

REM Check if the command was successful
if %errorlevel% EQU 0 (
    echo Successfully added the registry key: %regKey%
) else (
    echo Failed to add the registry key: %regKey%
    echo Error code: %errorlevel%
)

endlocal
pause
