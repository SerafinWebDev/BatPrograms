@echo off
SETLOCAL

:: Sprawdza, czy BitLocker jest zainstalowany na systemie
manage-bde -status >nul 2>&1
if %errorlevel% neq 0 (
    echo BitLocker nie jest zainstalowany w tym systemie.
    pause
    exit /b
)

:: Sprawdza status BitLocker na wszystkich dostępnych dyskach
echo Sprawdzanie statusu BitLocker na dyskach...

manage-bde -status

:: Informuje użytkownika o zakończeniu
echo.
echo Sprawdzenie statusu BitLocker zostało zakończone.
pause

ENDLOCAL