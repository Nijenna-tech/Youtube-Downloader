Nijenna YouTube Downloader
A user-friendly Windows Batch script designed to easily download YouTube videos and convert them directly to high-quality MP3 files.

Features
Automated Setup: Automatically downloads and configures yt-dlp and ffmpeg if they are not already present on your system.

Intelligent Detection: Automatically identifies whether the provided link is for a single video or a playlist.

Flexible Playlist Control: Offers customizable download options for playlists, allowing you to choose the number of tracks (25, 50, 75, 100, or all).

High-Quality Conversion: Utilizes ffmpeg to extract and convert audio to MP3 with the best available quality.

Portable & Simple: No installation of Python or complex environments required—just run start_2.bat.

Installation & Usage
Download start_2.bat.

Place the file in a folder of your choice.

Double-click start_2.bat to launch.

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
