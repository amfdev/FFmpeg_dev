
set ROOT_DIR=%CD%

git clone https://github.com/amfdev/libav.git ./libav-sync

cd ./libav-sync
git remote -v
git remote add upstream https://github.com/libav/libav.git
git remote -v
git fetch upstream
git checkout master
git merge upstream/master
git push

cd %ROOT_DIR%
