#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

if [ -d "$D/phpredis" ]; then
    rm -rf $D/phpredis
fi

$(git clone git://github.com/nicolasff/phpredis.git ${D}/phpredis)
cd $D/phpredis

phpize &&
./configure &&
make &&
sudo make install
