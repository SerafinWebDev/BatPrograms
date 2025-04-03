@echo off
setlocal

REM Define variables
set "dllFile=PassFiltEx.dll"
set "txtFile=PassFiltExBlacklist.txt"
set "destinationFolder=C:\Windows\System32"





REM Check and copy the DLL file
if not exist "%dllFile%" (
    echo Error: Source file "%dllFile%" not found!
    exit /b 1
)

echo start coping"%dllFile%"

copy "%dllFile%" "%destinationFolder%"
if errorlevel 1 (
    echo Error: Failed to copy "%dllFile%". Please check your permissions or the file itself.
    exit /b 2
) else (
    echo Successfully copied "%dllFile%" to "%destinationFolder%".
)


REM Check and copy the TXT file
if not exist "%txtFile%" (
    echo Error: Source file "%txtFile%" not found!
    exit /b 1
)

echo start coping "%txtFile%"

copy "%txtFile%" "%destinationFolder%"
if errorlevel 1 (
    echo Error: Failed to copy "%txtFile%". Please check your permissions or the file itself.
    exit /b 2
) else (
    echo Successfully copied "%txtFile%" to "%destinationFolder%".
	echo Zmiany wykonano prawidłowo.
)

endlocal
exit /b 0