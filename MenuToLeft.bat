@echo off
setlocal enabledelayedexpansion

set "key=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3"
set "exportfile=%temp%\StuckRects3_export.reg"
set "importfile=%temp%\StuckRects3_import.reg"

:: Export the StuckRects3 key
reg export "%key%" "%exportfile%" /y >nul 2>&1
if errorlevel 1 (
    echo Failed to export registry key.
    exit /b 1
)

:: Create the import file with the header
(
    echo Windows Registry Editor Version 5.00
    echo.
    for /f "usebackq tokens=*" %%A in ("%exportfile%") do (
        set "line=%%A"

        echo !line! | findstr /i "^\"Settings\"=hex:" >nul
        if !errorlevel! == 0 (
            rem Extract bytes after "hex:"
            for /f "tokens=1,* delims=:" %%i in ("!line!") do set "hexdata=%%j"
            rem Remove spaces and backslashes
            set "hexdata=!hexdata: =!"
            set "hexdata=!hexdata:\=!"
            rem Replace commas with spaces for easy handling
            set "hexdata=!hexdata:,= !"

            set /a count=0
            set "newline="

           for %%B in (!hexdata!) do (
    set /a count+=1
    set "byte=%%B"
    rem Change 13th byte if it is 03
    if !count! EQU 13 if /i "!byte!"=="03" set "byte=00"
    set "newline=!newline!!byte!,"
)

            rem Remove trailing comma
            set "newline=!newline:~0,-1!"
            echo "Settings"=hex:!newline!
        ) else (
            echo !line!
        )
    )
) > "%importfile%"

:: Import the modified .reg file
reg import "%importfile%"
if errorlevel 1 (
    echo Failed to import modified registry file.
    exit /b 1
)

echo The 15th byte in 'Settings' was changed from 03 to 00 successfully.
endlocal
