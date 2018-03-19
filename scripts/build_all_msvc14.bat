
rem set PATH=C:\Program Files (x86)\MSBuild\14.0\bin\amd64;%PATH%
rem set VSPATH=C:\Program Files (x86)\MSBuild\14.0\bin\amd64

set INCLUDE=C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\INCLUDE;C:\\Program Files (x86)\\Windows Kits\\8.1\\Include\\um\\;C:\\Program Files (x86)\\Windows Kits\\8.1\\Include\\shared\\;C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.10240.0\\ucrt
set INCLUDE=C:\\work\\thirdparty\\libs\\mingw-w64\\toolchain-x86_64\\x86_64-w64-mingw32\\include;%INCLUDE%

set LIB=C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\LIB\\amd64;C:\\Program Files (x86)\\Windows Kits\\8.1\\lib\\winv6.3\\um\\x64;C:\\Program Files (x86)\\Windows Kits\\10\\Lib\\10.0.10150.0\\ucrt\\x64
set LIB=C:\\work\\thirdparty\\libs\\mingw-w64\\toolchain-x86_64\\x86_64-w64-mingw32\\lib;%LIB%
ubuntu run sh -c './build_FFmpeg.sh mingw_msvc_x64'

rem set PATH=C:\Program Files (x86)\MSBuild\14.0\bin;%PATH%
rem set VSPATH=C:\Program Files (x86)\MSBuild\14.0\bin

set INCLUDE=C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\INCLUDE;C:\\Program Files (x86)\\Windows Kits\\8.1\\Include\\um\\;C:\\Program Files (x86)\\Windows Kits\\8.1\\Include\\shared\\;C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.10240.0\\ucrt
set INCLUDE=C:\\work\\thirdparty\\libs\\mingw-w64\\toolchain-i686\\i686-w64-mingw32\\include;%INCLUDE%

set LIB=C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\LIB;C:\\Program Files (x86)\\Windows Kits\\8.1\\lib\\winv6.3\\um\\x86;C:\\Program Files (x86)\\Windows Kits\\10\\Lib\\10.0.10150.0\\ucrt\\x86
set LIB=C:\\work\\thirdparty\\libs\\mingw-w64\\toolchain-i686\\i686-w64-mingw32\\lib;%LIB%
ubuntu run sh -c './build_FFmpeg.sh mingw_msvc_x86'
