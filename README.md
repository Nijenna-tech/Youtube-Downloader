# Nijenna YouTube Downloader BAT
A user-friendly Windows Batch script designed to easily download YouTube videos and convert them directly to high-quality MP3 files.

Features
Automated Setup: Automatically downloads and configures yt-dlp and ffmpeg if they are not already present on your system.

Intelligent Detection: Automatically identifies whether the provided link is for a single video or a playlist.

Flexible Playlist Control: Offers customizable download options for playlists, allowing you to choose the number of tracks (25, 50, 75, 100, or all).

High-Quality Conversion: Utilizes ffmpeg to extract and convert audio to MP3 with the best available quality.

Portable & Simple: No installation of Python or complex environments required—just run start_2.bat.

Installation & Usage
Download start.bat.

Place the file in a folder of your choice.

Double-click start.bat to launch.

On the first run, the script will check for the necessary dependencies (yt-dlp and ffmpeg). Follow the on-screen prompts and select J (Yes) to let the script download them automatically.

Paste your YouTube link and follow the menu instructions.

Requirements
Operating System: Windows.

Internet Connection: Required for the initial download of dependencies and for downloading media.

Troubleshooting
FFmpeg Missing: The script attempts to install FFmpeg automatically in the same directory as the script. If it fails, ensure that you have write permissions in that folder.

Antivirus Software: Some security software may flag Batch scripts that automatically download files from the internet. This is standard behavior for automated installers.

License
This project is intended for personal use. Please respect YouTube's Terms of Service and the copyright of the original content creators.

==== EXE VErsion ==== 
(Possible trojan detection from antivirus but its only selfloading yt-dlp and ffmpeg without showing and on your click)
# Nijenna YouTube Downloader EXE

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
Created by Nijenna.
