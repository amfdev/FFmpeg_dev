#!/bin/bash
#set -x

rm -fR ./AMF
git clone https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git

SOURCE=./AMF
REDIST=../AMF

rm -fR ${REDIST}
mkdir -p ${REDIST}/include/AMF
cp -R ${SOURCE}/amf/public/include/* ${REDIST}/include/AMF
rm -fR ./AMF
