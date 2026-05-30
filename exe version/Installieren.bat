@echo off
chcp 65001 >nul
title Nijenna Downloader - Zertifikats-Installation

:: Überprüfung auf Administratorrechte
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Fordere Administratorrechte an...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
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

:: Import mit Fehlerprüfung
powershell -Command "try { Import-Certificate -FilePath '%~dp0NijennaCert.cer' -CertStoreLocation 'Cert:\LocalMachine\Root' -ErrorAction Stop; Import-Certificate -FilePath '%~dp0NijennaCert.cer' -CertStoreLocation 'Cert:\LocalMachine\TrustedPublisher' -ErrorAction Stop; exit 0 } catch { exit 1 }"

if %errorlevel% equ 0 (
    echo [OK] Zertifikat wurde erfolgreich installiert.
    echo [OK] Nijenna Software wurde als vertrauenswürdig eingestuft.
    echo.
    set /p "choice=Zertifikat installiert? (j/n): "
    
    if /i "%choice%"=="j" (
        echo.
        echo Lösche Installationsdateien (NijennaCert.cer und Installieren.bat)...
        if exist "%~dp0NijennaCert.cer" del "%~dp0NijennaCert.cer"
        echo Fertig! Dieses Fenster schließt sich.
        (goto) 2>nul & del "%~f0"
    ) else (
        echo.
        echo Installationsdateien wurden nicht gelöscht.
        echo.
        echo ======================================================================
        echo  Fertig! Du kannst 'Nijenna Youtube Downloader.exe' jetzt starten.
        echo  Dieses Fenster schließt sich in Kürze automatisch...
        echo ======================================================================
        echo.
        timeout /t 5 >nul
        exit
    )
) else (
    echo [ERROR] Fehler bei der Installation des Zertifikats!
    echo Bitte stelle sicher, dass 'NijennaCert.cer' im selben Ordner liegt.
    echo.
    pause
    exit /b
)

