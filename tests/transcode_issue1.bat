..\_build-mingw_gcc_x64-debug\ffmpeg.exe -i %1 -c:v hevc_amf -quality quality -usage transcoding -b:v 8M -bufsize 16M -maxrate 12M %1.issue1.mkv
.\compare.bat %1 %1.dx11_hw.mkv


