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
sudo make install &&
echo "extension=redis.so" > $D/phpredis/redis.ini &&
sudo cp -f $D/phpredis/redis.ini /etc/php/conf.d/redis.ini
