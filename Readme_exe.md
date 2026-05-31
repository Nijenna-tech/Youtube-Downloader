# Nijenna YouTube Downloader

A secure and efficient tool to download media from YouTube, powered by `yt-dlp` and `ffmpeg` with a beautiful, distraction-free HTML user interface.

## Getting Started

Since this is a standalone executable and does not use complex installation routines or certificates, follow these simple steps to run it:

### 1. Handling Windows Smart App Control / SmartScreen (First Launch)
Because the executable is compiled from source and not distributed through a commercial App Store, Windows may flag it as unrecognized on the first launch. 

To run it without any security popups:
1. **Right-click** `Nijenna Youtube Downloader.exe`.
2. Select **Properties** (Eigenschaften).
3. At the bottom of the **General** (Allgemein) tab, look for the **Security** (Sicherheit) section and check the **Unblock** (Zulassen) box.
4. Click **Apply** (Übernehmen) and **OK**.

### 2. Running the Application
Once allowed, simply double-click:
- `Nijenna Youtube Downloader.exe`

A background web server will start, and the beautiful HTML interface will automatically open in your default browser. All download processes (via `yt-dlp` and `ffmpeg`) will run completely silently in the background without opening any annoying Command Prompt (CMD) windows!

## Dependencies
- This application relies on `yt-dlp.exe` and `ffmpeg.exe`. 
- When run, the application will automatically check for their presence. If they are missing, it can download and set them up automatically for you via the HTML setup interface.

## Troubleshooting
- **Smart App Control / Defender Block:** Windows 11 Smart App Control evaluates new files via cloud intelligence. Since the hash of a newly compiled `.exe` is unknown, it will block it until you manually check the **Unblock** (Zulassen) box in the file's properties (see Step 1).
- **Alternative Script Run:** If you prefer running the raw source without compiling or handling executable blocks, you can simply run the Python backend directly using the provided `start.bat` (which runs `python app.py` safely).

## License
Created by Nijenna Software.
