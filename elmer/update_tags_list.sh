#!/bin/sh

git status || exit 1

for COMMIT in $(git log | sed -ne 's/^commit //p') ; do
    SVN_REVISION="$(git show ${COMMIT} --stat | sed -ne 's:^.*elmerfem/code/trunk@\(.*\) .*:\1:p')"
    VERSION=$(git show "${COMMIT}:fem/configure" | sed -ne "s|^ VERSION=\(.*[0-9]\)$|\1|p")
    if [ -z "${SVN_REVISION}" ]; then
        echo "Failed to get svn revision at commit ${COMMIT}."
        continue
    fi
    if [ -z "${VERSION}" ]; then
        echo "Failed to get VERSION for revision ${SVN_REVISION} at commit ${COMMIT}."
    else
        FULL_VERSION="${VERSION}.svn.${SVN_REVISION}"
        echo git tag "${FULL_VERSION}" "${COMMIT}"
        git tag "${FULL_VERSION}" "${COMMIT}"
    fi
done

