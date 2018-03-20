#!/bin/bash
set -x

./build_FFmpeg.sh mingw_gcc_x64 rebuild debug
./build_FFmpeg.sh mingw_gcc_x86 rebuild debug
./build_FFmpeg.sh mingw_gcc_x64 rebuild release
./build_FFmpeg.sh mingw_gcc_x86 rebuild release
