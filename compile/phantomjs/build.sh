#!/bin/sh

# current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ $# -lt 1 ] ; then
    echo -e "Wrong number of parameters."
    echo -e "Usage:"
    echo -e " build.sh\n 'to' - phantomjs version, like: '1.8.0'\n"
    exit 1
fi

VERSION_OK="$(echo "$1" | grep '[1-2].*.*')"
if [ ! "$VERSION_OK" ]; then
    echo "Phantomjs version is not valid"
    exit 1
fi

if [ -d "$DIR/build" ]; then
    rm -rf $DIR/build
fi

has() {
    TMP=`which $1 2> /dev/null`
    [ $? -eq 0 ]
}

has "git" && git clone git://github.com/ariya/phantomjs.git $DIR/build

if [ ! -d "$DIR/build" ]; then
    echo "Install git version control"
    exit 1
fi

cd $DIR/build

git checkout $1
# workaround for http://code.google.com/p/phantomjs/issues/detail?id=635
sed -i 's/QMAKE_LFLAGS+=-fuse-ld=gold/#QMAKE_LFLAGS+=-fuse-ld=gold/' src/qt/src/3rdparty/webkit/Source/common.pri
./build.sh
sudo mv "$DIR/build/bin/phantomjs" "/usr/local/bin/."
