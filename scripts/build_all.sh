#!/bin/bash
set -x

./build.sh mingw_gcc_x64 rebuild debug
./build.sh mingw_gcc_x86 rebuild debug
