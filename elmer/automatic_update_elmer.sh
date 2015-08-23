#!/bin/sh

export DEBEMAIL="Boris Pek <tehnick-8@mail.ru>"

cd "$HOME/WorkDir/Elmer/Launchpad/"

# apt-get source elmerfem

if !([ -e elmerfem_*.orig.tar.gz ]); then
  echo "File elmerfem_*.orig.tar.gz is not found.";
  exit 0;
elif !([ -e elmerfem_*.debian.tar.gz ]); then
  echo "File elmerfem_*.debian.tar.gz is not found.";
  exit 0;
fi

export OLD_VER=$(ls elmerfem_*.orig.tar.gz | sed -e "s/^elmerfem_\(.*\).orig.tar.gz$/\1/")
export OLD_REVISION=$(echo "$OLD_VER" | sed -e "s/^.*svn\.\([0-9]\+\)\.dfsg$/\1/")
export LAST_REVISION=$(svn log https://elmerfem.svn.sourceforge.net/svnroot/elmerfem/trunk/ -r HEAD --quiet |grep "r[0-9]\+" | sed -e "s/^r\([0-9]\+\).*$/\1/")

echo "Number of old  revision: $OLD_REVISION"
echo "Number of last revision: $LAST_REVISION"

if [ $LAST_REVISION == $OLD_REVISION ]; then
  echo "Upgrading is not required.";
  exit 0;
fi

echo "Updating is started."

export CUR_VER=$(svn cat "https://elmerfem.svn.sourceforge.net/svnroot/elmerfem/trunk/fem/config.h" | grep "#define VERSION " | sed -e "s/^#define VERSION.*\"\(.*\)\"$/\1/")
export NEW_VER="$CUR_VER".svn."$LAST_REVISION".mybuild

echo "OLD_VER = $OLD_VER"
echo "NEW_VER = $NEW_VER"

rm trunk.tar.gz*
wget 'http://elmerfem.svn.sourceforge.net/viewvc/elmerfem/trunk.tar.gz?view=tar'
tar xzf 'trunk.tar.gz?view=tar'
mv trunk "elmerfem-$NEW_VER"
#svn export https://elmerfem.svn.sourceforge.net/svnroot/elmerfem/trunk/ "elmerfem-$NEW_VER"

tar -czf "elmerfem_$NEW_VER.orig.tar.gz" "elmerfem-$NEW_VER"

mv "elmerfem-$OLD_VER/debian" "elmerfem-$NEW_VER/"
rm -r "elmerfem-$OLD_VER" elmerfem_$OLD_VER*

cd "elmerfem-$NEW_VER"
dch -v "$NEW_VER-1" "Non-maintainer upload."
dch -a "Updating elmerfem packages."
# nano debian/changelog
# kwrite debian/changelog
# gedit debian/changelog
# medit debian/changelog

# debuild -S -sa
dpkg-buildpackage -rfakeroot

cd ..
# dput -f ubuntu elmerfem_$NEW_VER-1_source.changes

echo "Update finished successfully"

