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

has "svn" || (echo "Install svn"; exit 1)

# pick up the latest from svn
svn co svn://svn.lighttpd.net/xcache/trunk $DIR/build

cd $DIR/build

phpize
./configure --prefix=/usr
make
sudo make install

echo "extension=xcache.so" > $DIR/build/xcache.ini
echo "xcache.size=64M" >> $DIR/build/xcache.ini
echo "xcache.var_size=64M" >> $DIR/build/xcache.ini

sudo cp -f $DIR/build/xcache.ini /etc/php/conf.d/.
# move admin to web server
cp -rf $DIR/build/htdocs ~/php/xcache
