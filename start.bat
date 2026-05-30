@echo off
chcp 65001 >nul
title Nijenna YouTube Downloader

rem Native Methode um das ESC-Zeichen fuer Farben zu generieren (ohne PowerShell)
for /F "tokens=1 delims=#" %%a in ('"prompt #$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%a"

rem ==================================================
rem STARTUP: Einmalige Ueberpruefung der Abhaengigkeiten
rem ==================================================
cls
echo %ESC%[97m--------------------------------------------------
echo Nijenna %ESC%[91mYoutube%ESC%[97m Downloader
echo --------------------------------------------------%ESC%[0m
echo.
echo %ESC%[96mUeberpruefe Systemkomponenten...%ESC%[0m
echo.

rem 1. yt-dlp.exe pruefen und ggf. herunterladen
if not exist "%~dp0yt-dlp.exe" (
    where yt-dlp >nul 2>nul
    if errorlevel 1 (
        echo %ESC%[93mHinweis: yt-dlp.exe wurde nicht gefunden!%ESC%[0m
        echo yt-dlp wird benoetigt, um Videos von YouTube herunterzuladen.
        echo.
        choice /C JN /M "Moechtest du, dass ich yt-dlp automatisch herunterlade?"
        if errorlevel 2 (
            echo %ESC%[91mOhne yt-dlp kann dieses Skript keine Downloads durchfuehren.%ESC%[0m
            pause
            exit /b
        )
        echo.
        echo %ESC%[96mLade yt-dlp.exe herunter... Bitte warten...%ESC%[0m
        powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe' -OutFile 'yt-dlp.exe'"
        if exist "%~dp0yt-dlp.exe" (
            echo %ESC%[92myt-dlp erfolgreich eingerichtet!%ESC%[0m
            echo.
            timeout /t 2 >nul
        ) else (
            echo %ESC%[91mFehler beim Herunterladen von yt-dlp.exe%ESC%[0m
            pause
            exit /b
        )
    )
)

rem 2. ffmpeg.exe pruefen und ggf. herunterladen
if not exist "%~dp0ffmpeg.exe" (
    where ffmpeg >nul 2>nul
    if errorlevel 1 (
        echo %ESC%[93mHinweis: ffmpeg.exe wurde nicht gefunden!%ESC%[0m
        echo ffmpeg wird benoetigt, um Audio in MP3 zu konvertieren.
        echo.
        choice /C JN /M "Moechtest du, dass ich ffmpeg automatisch herunterlade?"
        if errorlevel 2 (
            echo %ESC%[91mKonvertierung zu MP3 wird ohne ffmpeg fehlschlagen.%ESC%[0m
            pause
            goto :menu
        )
        echo.
        echo %ESC%[96mLade FFmpeg herunter... Bitte warten...%ESC%[0m
        powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/GyanD/codexffmpeg/releases/download/7.1/ffmpeg-7.1-essentials_build.zip' -OutFile 'ffmpeg.zip'"
        if not exist "ffmpeg.zip" (
            echo %ESC%[91mFehler beim Herunterladen von ffmpeg.%ESC%[0m
            pause
            goto :menu
        )
        echo %ESC%[96mEntpacke FFmpeg...%ESC%[0m
        powershell -Command "Expand-Archive -Path 'ffmpeg.zip' -DestinationPath 'ffmpeg_temp'; Move-Item 'ffmpeg_temp\*\bin\ffmpeg.exe' '.\'; Move-Item 'ffmpeg_temp\*\bin\ffprobe.exe' '.\'; Remove-Item -Recurse -Force 'ffmpeg_temp', 'ffmpeg.zip'"
        if exist "%~dp0ffmpeg.exe" (
            echo %ESC%[92mFFmpeg erfolgreich eingerichtet!%ESC%[0m
            echo.
            timeout /t 2 >nul
        ) else (
            echo %ESC%[91mFehler beim Entpacken von ffmpeg.exe%ESC%[0m
            pause
        )
    )
)

rem ==================================================
rem HAUPTMENUE: Die eigentliche Programmschleife
rem ==================================================
:menu
cls
echo %ESC%[97m--------------------------------------------------
echo Nijenna %ESC%[91mYoutube%ESC%[97m Downloader
echo --------------------------------------------------%ESC%[0m
echo.

:askLink
set "YTLINK="
set /p "YTLINK=%ESC%[97mLink einfuegen: %ESC%[0m"

if "%YTLINK%"=="" (
    echo %ESC%[91mBitte gib einen gueltigen Link ein!%ESC%[0m
    timeout /t 2 >nul
    goto :menu
)

echo.
echo %ESC%[96mAnalysiere den Link... Bitte warten...%ESC%[0m

set "PLAYLIST_NAME="
for /F "delims=" %%i in ('yt-dlp.exe --no-config --flat-playlist --playlist-items 1 --print "%%(playlist)s" "%YTLINK%" 2^>nul') do set "PLAYLIST_NAME=%%i"

set "PLAYLIST_FLAG=--no-playlist"
set "IS_PLAYLIST=1"
if "%PLAYLIST_NAME%"=="" set "IS_PLAYLIST=0"
if "%PLAYLIST_NAME%"=="NA" set "IS_PLAYLIST=0"
if "%PLAYLIST_NAME%"=="none" set "IS_PLAYLIST=0"
set "OUT_TEMPLATE=%~dp0Musik\%%(title)s.%%(ext)s"
set "DISPLAY_FOLDER=%~dp0Musik"

if not "%IS_PLAYLIST%"=="1" goto :isSingleVideo

echo.
echo %ESC%[93mDieser Link gehoert zu einer Playlist/einem Mix: %PLAYLIST_NAME%%ESC%[0m
echo [1] Nur dieses eine Lied herunterladen
echo [2] Die gesamte Playlist herunterladen
echo.
choice /C 12 /M "Deine Auswahl:"
if errorlevel 2 (
    set "PLAYLIST_FLAG=--yes-playlist"
    set "OUT_TEMPLATE=%~dp0Musik\%%(playlist)s\%%(title)s.%%(ext)s"
    set "DISPLAY_FOLDER=%~dp0Musik\%PLAYLIST_NAME%"
    
    echo.
    echo %ESC%[97mWie viele Lieder der Playlist moechtest du laden?%ESC%[0m
    echo [1] Die ersten 25 Lieder
    echo [2] Die ersten 50 Lieder
    echo [3] Die ersten 75 Lieder
    echo [4] Die ersten 100 Lieder
    echo [5] Die gesamte Playlist (Alles)
    echo.
    choice /C 12345 /M "Deine Auswahl:"
    if errorlevel 5 (
        echo %ESC%[92mDie gesamte Playlist wird heruntergeladen.%ESC%[0m
    ) else if errorlevel 4 (
        set "PLAYLIST_FLAG=--yes-playlist --playlist-end 100"
        echo %ESC%[92mDie ersten 100 Lieder werden heruntergeladen.%ESC%[0m
    ) else if errorlevel 3 (
        set "PLAYLIST_FLAG=--yes-playlist --playlist-end 75"
        echo %ESC%[92mDie ersten 75 Lieder werden heruntergeladen.%ESC%[0m
    ) else if errorlevel 2 (
        set "PLAYLIST_FLAG=--yes-playlist --playlist-end 50"
        echo %ESC%[92mDie ersten 50 Lieder werden heruntergeladen.%ESC%[0m
    ) else if errorlevel 1 (
        set "PLAYLIST_FLAG=--yes-playlist --playlist-end 25"
        echo %ESC%[92mDie ersten 25 Lieder werden heruntergeladen.%ESC%[0m
    )
) else (
    set "PLAYLIST_FLAG=--no-playlist"
    echo %ESC%[92mNur das einzelne Lied wird heruntergeladen.%ESC%[0m
)
goto :playlistCheckEnd

:isSingleVideo
echo %ESC%[92mEinzelvideo erkannt.%ESC%[0m

:playlistCheckEnd

if not exist "%~dp0Musik" (
    mkdir "%~dp0Musik"
)

echo.
echo %ESC%[96mDownloade und konvertiere zu MP3...%ESC%[0m
echo.

yt-dlp.exe %PLAYLIST_FLAG% -x --audio-format mp3 --audio-quality 0 --ffmpeg-location "%~dp0." -o "%OUT_TEMPLATE%" "%YTLINK%"

if errorlevel 0 (
    echo.
    echo %ESC%[92mDownload und Konvertierung erfolgreich abgeschlossen!%ESC%[0m
    echo Die Dateien befinden sich im Ordner: %ESC%[97m%DISPLAY_FOLDER%%ESC%[0m
) else (
    echo.
    echo %ESC%[91mEs gab einen Fehler beim Download oder bei der Konvertierung.%ESC%[0m
)

echo.
choice /C JN /M "Moechtest du weitere Videos herunterladen?"
if errorlevel 2 (
    exit /b
)
goto :menu
