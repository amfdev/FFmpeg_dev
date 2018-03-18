#!/bin/bash
set -x

ROOT_DIR=$PWD

[ -d "$THIRDPARTY_DIR" ] || THIRDPARTY_DIR=`readlink -f ${ROOT_DIR}/../thirdparty`
[ -d "$THIRDPARTY_DIR" ] || THIRDPARTY_DIR=`readlink -f ${ROOT_DIR}/../../thirdparty`
[ -d "$THIRDPARTY_DIR" ] || (echo thirdparty not found && exit 1)

echo THIRDPARTY_DIR=$THIRDPARTY_DIR
