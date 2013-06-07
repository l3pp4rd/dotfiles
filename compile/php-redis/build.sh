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

has "git" && git clone git://github.com/nicolasff/phpredis.git $DIR/build

if [ ! -d "$DIR/build" ]; then
    echo "Install git version control"
    exit 1
fi

cd $DIR/build

phpize &&
./configure &&
make &&
sudo make install &&
echo "extension=redis.so" > $DIR/build/redis.ini &&
sudo cp -f $DIR/build/redis.ini /etc/php/conf.d/redis.ini

