# Nijenna YouTube Downloader

A secure and efficient tool to download media from YouTube, powered by `yt-dlp` and `ffmpeg`.

## Getting Started

To ensure the application runs smoothly and is recognized as trusted by Windows, please follow these steps:

### 1. Installation & Trust
Before running the application for the first time, you must install the security certificate to establish trust:
1. Run `Installieren.bat` as an **Administrator**.
2. This will import the `NijennaCert.cer` into your local machine's trusted certificate store.
3. Once the process completes successfully, the Windows security warning will be cleared for this application.

### 2. Running the Application
After installing the certificate, simply execute:
- `Nijenna Youtube Downloader.exe`

## Dependencies
- This application relies on `yt-dlp` and `ffmpeg`. These are bundled with the executable.
- Requires Python (if running from source) or the provided standalone `.exe`.

## Troubleshooting
- **Smart App Control:** If you encounter issues, ensure that "Smart App Control" settings in Windows allow unsigned or custom-signed applications, or confirm that the certificate was imported successfully.
- **Administrator Rights:** The `Installieren.bat` script requires administrative privileges to modify the system's root certificate store.

## License
Created by Nijenna Software.