..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel d3d11va -i %1 -an -c:v hevc_amf -quality balanced %1.dx11_balanced_265.mkv 
..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel d3d11va -i %1 -an -c:v hevc_amf -quality quality %1.dx11_quality_265.mkv 
..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel d3d11va -i %1 -an -c:v hevc_amf -quality speed %1.dx11_speed_265.mkv 



..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel d3d11va -i %1 -an -c:v h264_amf -quality balanced %1.dx11_balanced_264.mkv 
..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel d3d11va -i %1 -an -c:v h264_amf -quality quality %1.dx11_quality_264.mkv 
..\_build-mingw_gcc_x64-debug\ffmpeg.exe -hide_banner -y -hwaccel d3d11va -i %1 -an -c:v h264_amf -quality speed %1.dx11_speed_264.mkv 
