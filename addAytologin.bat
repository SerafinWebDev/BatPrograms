@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Prośba o podanie nazwy użytkownika i hasła
set /p "username=Podaj nazwę użytkownika: "
set /p "password=Podaj hasło: "

:: Ustawia automatyczne logowanie dla podanego użytkownika
echo Ustawianie automatycznego logowania dla użytkownika: %username%

:: Klucz rejestru dla automatycznego logowania
set "regkey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

:: Tworzenie wpisów w rejestrze
reg add "%regkey%" /v AutoAdminLogon /t REG_SZ /d 1 /f
reg add "%regkey%" /v DefaultUsername /t REG_SZ /d "%username%" /f
reg add "%regkey%" /v DefaultPassword /t REG_SZ /d "%password%" /f

echo Automatyczne logowanie zostało ustawione dla %username%.

:: Weryfikacja
reg query "%regkey%" /v AutoAdminLogon
reg query "%regkey%" /v DefaultUsername
reg query "%regkey%" /v DefaultPassword

ENDLOCAL
pause