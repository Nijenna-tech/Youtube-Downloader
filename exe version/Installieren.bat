@echo off
chcp 65001 >nul
title Nijenna Downloader - Zertifikats-Installation

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Fordere Administratorrechte an...
    powershell -Command "Start-Process -FilePath 'cmd.exe' -ArgumentList ('/c ' + [char]34 + '%~f0' + [char]34) -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

echo.
echo ======================================================================
echo             Nijenna YouTube Downloader - Setup Center
echo ======================================================================
echo.
echo Installiere Sicherheitszertifikat...
echo.

:: Import certificate
powershell -Command "try { Import-Certificate -FilePath '%~dp0NijennaCert.cer' -CertStoreLocation 'Cert:\LocalMachine\Root' -ErrorAction Stop; Import-Certificate -FilePath '%~dp0NijennaCert.cer' -CertStoreLocation 'Cert:\LocalMachine\TrustedPublisher' -ErrorAction Stop; exit 0 } catch { exit 1 }"

if %errorlevel% neq 0 (
    echo [ERROR] Fehler bei der Installation des Zertifikats!
    echo Bitte stelle sicher, dass 'NijennaCert.cer' im selben Ordner liegt.
    echo.
    pause
    exit /b
)

echo [OK] Zertifikat wurde erfolgreich installiert.
echo [OK] Nijenna Software wurde als vertrauenswuerdig eingestuft.
echo.

:ASK_DELETE
set /p choice="Moechtest du die Installationsdateien (.bat und .cer) jetzt loeschen? (j/n): "
if /i "%choice%"=="j" goto DELETE_FILES
if /i "%choice%"=="n" goto KEEP_FILES
echo Ungueltige Eingabe. Bitte j oder n eingeben.
echo.
goto ASK_DELETE

:DELETE_FILES
echo.
echo Loesche Installationsdateien...
if exist "%~dp0NijennaCert.cer" del "%~dp0NijennaCert.cer"
echo Fertig! Dieses Fenster schliess sich in Kuerze.
timeout /t 3 >nul
del "%~f0"
exit

:KEEP_FILES
echo.
echo Installationsdateien wurden nicht geloescht.
echo.
echo ======================================================================
echo  Fertig! Du kannst 'Nijenna Youtube Downloader.exe' jetzt starten.
echo  Dieses Fenster schliesst sich in Kürze automatisch...
echo ======================================================================
echo.
timeout /t 5 >nul
exit
