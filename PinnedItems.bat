@echo off
setlocal

:: Define variables for Windows Settings
set "settingsPath=ms-settings:"
set "shortcutName=Settings"
set "shortcutPath=C:\Users\Klaudiusz\AppData\Microsoft\Windows\Start Menu\Programs\%shortcutName%.lnk"

:: Create a temporary VBScript to create the shortcut
(
echo Set oWS = WScript.CreateObject("WScript.Shell")
echo sLinkFile = "%shortcutPath%"
echo Set oLink = oWS.CreateShortcut(sLinkFile)
echo oLink.TargetPath = "%settingsPath%"
echo oLink.Save
) > "%TEMP%\CreateSettingsShortcut.vbs"

:: Run the VBScript
cscript //nologo "%TEMP%\CreateSettingsShortcut.vbs"

:: Clean up
del "%TEMP%\CreateSettingsShortcut.vbs"

:: PowerShell command to pin the shortcut to Start
powershell -command "Start-Process -FilePath 'explorer.exe' -ArgumentList 'shell:AppsFolder' -Verb RunAs"
timeout /t 2 > nul
powershell -command "$shell = New-Object -ComObject Shell.Application; $folder = $shell.Namespace('C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs'); $item = $folder.Items() | Where-Object { $_.Name -eq '$shortcutName' }; $item.InvokeVerb('pin to start')"

echo Shortcut to Settings Panel created and pinned to Start: %shortcutPath%
endlocal
exit /b 0