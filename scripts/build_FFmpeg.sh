#!/bin/bash
ROOT_DIR=$PWD

target=$1
task=$2
config=$3

[ -z "$target" ] && echo target is not specified && exit 1
[ -z "$task" ] && task=rebuild
[ -z "$config" ] && config=release

[ "$task" != "build" ] && [ "$task" != "rebuild" ] && echo invalid task $task. must be build or rebuild && exit 1
[ "$config" != "release" ] && [ "$config" != "debug" ] && echo invalid config $config. must be release or debug && exit 1

[ -d "$thirdparty" ] || thirdparty=`readlink -f ${ROOT_DIR}/../thirdparty`
[ -d "$thirdparty" ] || thirdparty=`readlink -f ${ROOT_DIR}/../../thirdparty`
[ ! -d "$thirdparty" ] && echo thirdparty not found && exit 1

[ -d "$SOURCE_DIR" ] || SOURCE_DIR=`readlink -f ${ROOT_DIR}/FFmpeg`
[ -d "$SOURCE_DIR" ] || SOURCE_DIR=`readlink -f ${ROOT_DIR}/../FFmpeg`
[ -d "$SOURCE_DIR" ] || SOURCE_DIR=`readlink -f ${ROOT_DIR}/../../FFmpeg`
[ ! -d "$SOURCE_DIR" ] && echo FFmpeg source not found && exit 1

[ -z "$BUILD_DIR" ] && BUILD_DIR=$ROOT_DIR/FFmpeg-$target-$config
[ ! -d "$BUILD_DIR" ] && task=rebuild

echo target=$target
echo task=$task
echo config=$config
echo thirdparty=$thirdparty
echo source=$SOURCE_DIR
echo build=$BUILD_DIR

. "$thirdparty/scripts/toolset/$1" || exit 1

if [ "$COMPILER" == "msvc" ]; then
    [ "$config" == "debug" ] && debugflags="--enable-debug"

    extracflags=
    extralinkflags=
    #--extra-ldflags="-DEBUG"
else
    [ "$config" == "debug" ] && debugflags="--enable-debug --disable-optimizations"

    extracflags=
    extralinkflags="--extra-ldflags=-static-libgcc"
fi

if [ "$task" == "rebuild" ]; then
    rm -fR $BUILD_DIR
fi
mkdir -p $BUILD_DIR && cd $BUILD_DIR

AMF_INCLUDE_DIR=../../../thirdparty/libs/AMF/include
X264_REDIST_DIR=../../../thirdparty/libs/x264/$target
X265_REDIST_DIR=../../../thirdparty/libs/x265/$target
export PKG_CONFIG_PATH=${BUILD_DIR}/${X264_REDIST_DIR}:${PKG_CONFIG_PATH}
export PKG_CONFIG_PATH=${BUILD_DIR}/${X265_REDIST_DIR}:${PKG_CONFIG_PATH}
cp $X264_REDIST_DIR/bin/*.dll .
cp $X265_REDIST_DIR/bin/*.dll .


amf_params="--enable-amf --extra-cflags=-I$AMF_INCLUDE_DIR"
x265_params="--enable-gpl --enable-libx265"
x264_params="--enable-gpl --enable-libx264"


if [ "$COMPILER" == "msvc" ]; then

    [ "$task" == "rebuild" ] && cp -r $SOURCE_DIR/* $BUILD_DIR
    [ "$task" == "rebuild" ] && $BUILD_DIR/configure --toolchain=msvc --enable-cross-compile --cc=cl.exe --ld=link.exe \
        --pkg-config=`which pkg-config` \
        $extracflags $extralinkflags $debugflags $x264_params $x265_params $amf_params

    make
fi
if [ "$COMPILER" == "gcc" ]; then

    [ "$task" == "rebuild" ] && $SOURCE_DIR/configure --target-os=$PLATFORM --arch=$FULLARCH --cross-prefix=$CROSS_PREFIX \
        --pkg-config=`which pkg-config` \
		$extracflags $extralinkflags $debugflags $x264_params $x265_params $amf_params

    make -j${NPROC}
fi

cd $ROOT_DIR


