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

git clone git://github.com/mongodb/mongo-php-driver.git $DIR/build

cd $DIR/build

git checkout 1.4.2

phpize &&
./configure &&
make &&
sudo make install &&
echo "extension=mongo.so" > $DIR/build/mongo.ini &&
sudo cp -f $DIR/build/mongo.ini /etc/php/conf.d/mongo.ini

