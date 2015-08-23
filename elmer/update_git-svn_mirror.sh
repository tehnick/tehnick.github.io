#!/bin/sh

# Test Internet connection:
host github.com > /dev/null || exit 1

export MAIN_DIR="${HOME}/WorkDir/Devel/Elmer"

echo "MAIN_DIR = ${MAIN_DIR}"
echo ;

cd "${MAIN_DIR}/elmerfem_trunk__git" || exit 1
git status || exit 1
echo ;

STATUS="$(git status)"

if [ "$(echo "${STATUS}" | grep 'On branch master' | wc -l)" -eq 0 ]; then
    echo "You are not in master branch!";
    echo "You should checkout in master branch first...";
    exit 1;
fi

if [ "$(echo "${STATUS}" | grep 'Changes not staged for commit:' | wc -l)" -eq 1 ]; then
    echo "There are not staged changes in the source tree!:";
    echo "You should process them before sync...";
    exit 1;
fi

if [ "$(echo "${STATUS}" | grep 'nothing to commit, working directory clean' | wc -l)" -eq 0 ]; then
    echo "Is something wrong?";
    exit 1;
fi

git svn rebase || exit 1
echo ;

OLD_VER=$(git tag -l | sort -V | tail -n1)
OLD_REVISION=$(echo ${OLD_VER} | sed -e "s/^[0-9]\+\.[0-9]\+\.\([0-9]\+\)$/\1/")

CUR_VER=$(grep "\ VERSION=" fem/configure | sed -e "s/^ VERSION=\(.\+\)$/\1/")
if [ -z "${CUR_VER}" ]; then
    echo "Failed to define current version."
    exit 1
fi

LAST_COMMIT=$(git show --stat | grep 'elmerfem/trunk' | sed -e "s|^.*elmerfem/trunk@\([0-9]\+\) .*$|\1|")
if [ -z "${LAST_COMMIT}" ]; then
    echo "Failed to define last commit."
    exit 1
else
    NEW_VER="${CUR_VER}.svn.${LAST_COMMIT}"
    if [ "${NEW_VER}" != "${OLD_VER}" ]; then
        echo git tag "${NEW_VER}"
        git tag "${NEW_VER}"
    fi
fi

git status || exit 1
echo ;

STATUS="$(git status)"

if [ "$(echo "${STATUS}" | grep '# Your branch is ahead of' | wc -l)" -eq 1 ]; then
    git push origin master
    git push --tags
    exit 0;
fi

