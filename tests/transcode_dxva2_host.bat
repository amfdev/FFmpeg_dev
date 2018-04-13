..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel dxva2 -i %1 -an -c:v h264_amf %1.dxva2_host.mkv
.\compare.bat %1 %1.dxva2_host.mkv


