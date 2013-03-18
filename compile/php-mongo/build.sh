#!/bin/sh

# current directory
D="$( cd "$( dirname "$0" )" && pwd )"

if [ -d "$D/phpmongo" ]; then
    rm -rf $D/phpmongo
fi

NA=`which git | grep "not found" | wc -l`
if [ $NA -eq 1 ]; then
    echo "Install git version control"
    exit 1
fi

$(git clone git://github.com/mongodb/mongo-php-driver.git ${D}/phpmongo)
cd $D/phpmongo

phpize &&
./configure &&
make &&
sudo make install &&
echo "extension=mongo.so" > $D/phpmongo/mongo.ini &&
sudo cp -f $D/phpmongo/mongo.ini /etc/php/conf.d/mongo.ini
