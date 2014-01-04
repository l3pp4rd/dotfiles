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

has "hg" && hg clone https://vim.googlecode.com/hg/ $DIR/build

if [ ! -d "$DIR/build" ]; then
    echo "Install mercurial version control"
    exit 1
fi

cd $DIR/build

./configure \
--prefix=/usr/local \
--with-features=huge \
--disable-largefile \
--enable-perlinterp \
--enable-rubyinterp \
--enable-pythoninterp \
--enable-python3interp \
--enable-luainterp
--enable-gpm \
--enable-acl \
--with-x=no \
--disable-gui \
--enable-multibyte \
--enable-cscope \
--disable-netbeans

make
sudo make install

