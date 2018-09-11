#!/bin/bash

set -x

ROOT_DIR=$PWD

target=$1
task=$2
config=$3
link=$4

[ -z "$target" ] && echo target is not specified && exit 1
[ -z "$task" ] && task=rebuild
[ -z "$config" ] && config=release
[ -z "$link" ] && [ "$config" == "release" ] && link=static
[ -z "$link" ] && [ "$config" == "debug" ] && link=shared

[ "$task" != "build" ] && [ "$task" != "rebuild" ] && echo invalid task $task. must be build or rebuild && exit 1
[ "$config" != "release" ] && [ "$config" != "debug" ] && echo invalid config $config. must be release or debug && exit 1
[ "$link" != "static" ] && [ "$link" != "shared" ] && echo invalid link $link. must be static or shared && exit 1

[ -d "$thirdparty" ] || thirdparty=`readlink -f ${ROOT_DIR}/../thirdparty`
[ -d "$thirdparty" ] || thirdparty=`readlink -f ${ROOT_DIR}/../../thirdparty`
[ ! -d "$thirdparty" ] && echo thirdparty not found && exit 1

[ -d "$SOURCE_DIR" ] || SOURCE_DIR=`readlink -f ${ROOT_DIR}/Sources`
[ -d "$SOURCE_DIR" ] || SOURCE_DIR=`readlink -f ${ROOT_DIR}/../Sources`
[ ! -d "$SOURCE_DIR" ] && echo Sources dir not found && exit 1

[ -z "$BUILD_DIR" ] && BUILD_DIR=$ROOT_DIR/_build-$target-$config
[ -z "$REDIST_DIR" ] && REDIST_DIR=$ROOT_DIR/_build-redist-$target-$config
[ ! -d "$BUILD_DIR" ] && task=rebuild

[ -d "$SOURCE_DIR/avbuild" ] && LIBNAME=libav
[ -d "$SOURCE_DIR/ffbuild" ] && LIBNAME=ffmpeg


echo target=$target
echo task=$task
echo config=$config
echo thirdparty=$thirdparty
echo source=$SOURCE_DIR
echo build=$BUILD_DIR

. "$thirdparty/scripts/toolset/$1" || exit 1

if [ "$COMPILER" == "msvc" ]; then
    [ "$config" == "debug" ] && debugflags="--enable-debug"
else
    [ "$config" == "debug" ] && debugflags="--enable-debug --disable-optimizations"
    [ ! "$config" == "debug" ] && debugflags=--disable-debug
    
    [ "$link" == "static" ] && linkflags="--extra-ldflags=-static --pkg-config-flags=--static"
    [ "$link" == "shared" ] && linkflags="--extra-ldflags=-static-libgcc"
fi

if [ "$task" == "rebuild" ]; then
    rm -fR $BUILD_DIR
fi
mkdir -p $BUILD_DIR && cd $BUILD_DIR

[ -z "$AMF_INCLUDE_DIR" ] && AMF_INCLUDE_DIR="AMF/include"
[ -d "$AMF_INCLUDE_DIR" ] || AMF_INCLUDE_DIR="../AMF/include"
[ -d "$AMF_INCLUDE_DIR" ] || AMF_INCLUDE_DIR="../../AMF/include"
[ ! -d "$AMF_INCLUDE_DIR" ] && echo Sources not found && exit 1

amf_params="--enable-amf --extra-cflags=-I$AMF_INCLUDE_DIR"

OCL_ROOT=$thirdparty/libs/OCL
ocl_params="--enable-opencl --extra-cflags=-I${OCL_ROOT}/include --extra-ldflags=-L${OCL_ROOT}/lib/$ARCH_LIB"

if [ "$LIBNAME" == "libav" ]; then
    LIBOPT=
    LIBOPT2=
fi
if [ "$LIBNAME" == "ffmpeg" ]; then
    LIBOPT=--ln_s='cp -R\'
    LIBOPT2="--enable-sdl2 $ocl_params"
fi

if [ "$COMPILER" == "msvc" ]; then
    echo $COMPILER is temporary not supported && exit 1

#    [ "$task" == "rebuild" ] && cp -r $SOURCE_DIR/* $BUILD_DIR
#    [ "$task" == "rebuild" ] && $BUILD_DIR/configure --toolchain=msvc --enable-cross-compile --cc=cl.exe --ld=link.exe \
#        $debugflags --enable-gpl --enable-libx264 --enable-libx265 --enable-sdl2 $amf_params

#    make
fi

if [ "$COMPILER" == "gcc" ] && [ "$LIBNAME" == "ffmpeg" ]; then

    [ "$task" == "rebuild" ] && time.sh $SOURCE_DIR/configure --target-os=$PLATFORM --arch=x86 --cross-prefix=${TARGET}- --prefix="$REDIST_DIR" \
        --ln_s='cp -R' \
        --pkg-config=`which pkg-config` $linkflags \
        $debugflags --enable-gpl --enable-libx264 --enable-libx265 $amf_params --enable-sdl2 $ocl_params
    
    [ "$link" == "shared" ] && cp -v ${ARCH_DIR}/${TARGET}/bin/libx265.dll ./
    [ "$link" == "shared" ] && cp -v ${ARCH_DIR}/${TARGET}/../bin/SDL2.dll ./
    time.sh make -j${NPROC}
fi
if [ "$COMPILER" == "gcc" ] && [ "$LIBNAME" == "libav" ]; then

    [ "$task" == "rebuild" ] && time.sh $SOURCE_DIR/configure --target-os=$PLATFORM --arch=x86 --cross-prefix=${TARGET}- --prefix="$REDIST_DIR" \
        --pkg-config=`which pkg-config` $linkflags \
        $debugflags --enable-gpl --enable-libx264 --enable-libx265 $amf_params
    
    [ "$link" == "shared" ] && cp -v ${ARCH_DIR}/${TARGET}/bin/libx265.dll ./
    time.sh make -j${NPROC}
fi

if [ "$LIBNAME" == "libav" ]; then
    cp -T $BUILD_DIR/avconv.exe $BUILD_DIR/ffmpeg_g.exe
    cp -T $BUILD_DIR/avprobe.exe $BUILD_DIR/ffprobe_g.exe
    cp -T $BUILD_DIR/avconv.exe $BUILD_DIR/ffmpeg.exe
    cp -T $BUILD_DIR/avprobe.exe $BUILD_DIR/ffprobe.exe
fi

cd $ROOT_DIR

