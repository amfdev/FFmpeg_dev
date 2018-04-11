..\_build-mingw_gcc_x64-debug\ffmpeg.exe -y -hwaccel dxva2 -hwaccel_output_format dxva2_vld  -i %1 -an -c:v h264_amf %1.dxva2_hw.mkv
.\compare.bat %1 %1.dxva2_hw.mkv

