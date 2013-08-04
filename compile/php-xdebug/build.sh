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

has "git" || (echo "Install git"; exit 1)

git clone git://github.com/derickr/xdebug.git $DIR/build

cd $DIR/build

git checkout XDEBUG_2_2_2

phpize &&
./configure &&
make &&
sudo make install &&
echo "zend_extension=xdebug.so" > $DIR/build/xdebug.ini &&
sudo cp -f $DIR/build/xdebug.ini /etc/php/conf.d/.

