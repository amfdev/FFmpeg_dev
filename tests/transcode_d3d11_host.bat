..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel d3d11va -i %1 -an -c:v h264_amf %1.dx11_host.mkv
.\compare.bat %1 %1.dx11_host.mkv


