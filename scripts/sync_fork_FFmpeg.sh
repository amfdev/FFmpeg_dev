#!/bin/bash
#set -x

ROOT_DIR=$PWD



git clone https://github.com/amfdev/FFmpeg.git ./FFmpeg-sync

cd ./FFmpeg-sync
git remote -v
git remote add upstream https://github.com/FFmpeg/FFmpeg.git
git remote -v
git fetch upstream
git checkout master
git merge upstream/master

#git push

cd $ROOT_DIR
