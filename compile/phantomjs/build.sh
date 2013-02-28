#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

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

if [ -d "$D/build" ]; then
    rm -rf "$D/build"
fi

$(git clone git://github.com/ariya/phantomjs.git ${D}/build)
cd $D/build
git checkout $1
# workaround for http://code.google.com/p/phantomjs/issues/detail?id=635
sed -i 's/QMAKE_LFLAGS+=-fuse-ld=gold/#QMAKE_LFLAGS+=-fuse-ld=gold/' src/qt/src/3rdparty/webkit/Source/common.pri
./build.sh
sudo install -D -m755 "$D/build/bin/phantomjs" "/usr/local/bin/"
