#!/bin/sh

# current directory
DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ -d "$DIR/build" ]; then
    rm -rf $DIR/build
fi

has() {
    TMP=`which $1 2> /dev/null`
    [ $? -eq 0 ]
}

has "git" && git clone git://github.com/l3pp4rd/dwm.git $DIR/build

if [ ! -d "$DIR/build" ]; then
    echo "Install git version control"
    exit 1
fi

cd $DIR/build

# install
make
sudo make install

