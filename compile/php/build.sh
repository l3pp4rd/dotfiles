#!/bin/sh

# For ArchLinux environment

DIR="$( cd "$( dirname "$0" )" && pwd )"

if [[ $# -lt 1 ]] || [[ "$1" == "?" ]] || [[ "$1" == "--help" ]] ||  [[ "$1" == "-h" ]]
then
    echo -e "Usage: build \033[33msource_dir\033[0m \033[32m[options]\033[0m"
    echo -e "  Arguments:"
    echo -e "    \033[33msource_dir\033[0m     php source directory, example: '~/php/php-5.4'"
    echo -e "  Options:"
    echo -e "    \033[32m--debug\033[0m        build with debug enabled"
    echo -e "\n  When finished, run make install afterwards, or make test first"
    exit 1
fi

if [ ! -d "$1" ]
then
    echo "Php source is not a valid directory"
    exit 2
fi

PHP_CONF="--config-cache \
    --prefix=/usr \
    --sysconfdir=/etc/php \
    --localstatedir=/var \
    --with-layout=GNU \
    --with-config-file-path=/etc/php \
    --with-config-file-scan-dir=/etc/php/conf.d \
    --disable-rpath \
    --mandir=/usr/share/man \
"

MAY_BE_USED="--enable-ftp \
    --enable-exif \
    --enable-calendar \
    --with-snmp=/usr \
    --with-pspell \
    --with-tidy=/usr \
    --with-xmlrpc \
    --with-xsl=/usr \
"

EXT_CONF="--enable-mbstring \
    --enable-mbregex \
    --enable-phar \
    --enable-posix \
    --enable-soap \
    --enable-sockets \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-zip \
    --enable-inline-optimization \
    --enable-intl \
    --with-icu-dir=/usr \
    --with-curl=/usr/bin \
    --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=shared,/usr \
    --with-freetype-dir=/usr \
    --with-bz2=/usr \
    --with-gettext \
    --with-iconv-dir=/usr \
    --with-mcrypt=/usr \
    --with-mhash \
    --with-zlib-dir=/usr \
    --with-xpm-dir=/usr \
    --with-regex=php \
    --with-pcre-regex=/usr \
    --with-openssl \
    --with-openssl-dir=/usr/bin \
    --with-mysql-sock=/var/run/mysqld/mysqld.sock \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pgsql=/usr \
    --with-sqlite3=/usr \
    --with-pdo-mysql=/usr \
    --with-pdo-pgsql=/usr \
    --with-pdo-sqlite=/usr
"

if [[ $# -gt 1 && "$2" == "--debug" ]]
then
    PHP_CONF="$PHP_CONF \
    --enable-debug \
    --enable-maintainer-zts \
"
else
    PHP_CONF="$PHP_CONF \
    --disable-debug \
"
fi

EXTENSION_DIR=/usr/lib/php/modules
export EXTENSION_DIR
PEAR_INSTALLDIR=/usr/share/pear
export PEAR_INSTALLDIR
# new icu libs for intl does not include this stdc++ lib ld flag
EXTRA_LIBS=-lstdc++
export EXTRA_LIBS

if [ ! -d "/usr/lib/php/modules" ] ; then
    sudo mkdir -p /usr/lib/php/modules
fi

if [ ! -d "/etc/php/conf.d" ] ; then
    sudo mkdir -p /etc/php/conf.d
fi

if [ ! -d "/usr/share/pear" ] ; then
    sudo mkdir -p /usr/share/pear
fi

cd "$1"

NA=`grep "pcre_info" ext/pcre/php_pcre.c | wc -l`

# patch for older pcre based php versions
if [ $NA -gt 0 ]; then
    # recent pcre lib from version 8.30 does not support "pcre_info" anymore
    sed 's/pcre_info/pcre_fullinfo/g' ext/pcre/php_pcre.c > temp
    mv temp ext/pcre/php_pcre.c
    sed 's/pcre_fullinfo(pce->re, NULL, NULL)/pcre_fullinfo\(pce->re, NULL, PCRE_INFO_CAPTURECOUNT, \&count\)/g' ext/pcre/php_pcre.c > temp
    mv temp ext/pcre/php_pcre.c
    sed 's/unsigned const char \*tables/int count = 0;unsigned const char \*tables/g' ext/pcre/php_pcre.c > temp
    mv temp ext/pcre/php_pcre.c
    sed 's/pcre_info/pcre_fullinfo/g' ext/pcre/pcrelib/pcre.h > temp
    mv temp ext/pcre/pcrelib/pcre.h
    sed 's/pcre_info/pcre_fullinfo/g' ext/pcre/pcrelib/pcreposix.c > temp
    mv temp ext/pcre/pcrelib/pcreposix.c
    sed 's/pcre_info/pcre_fullinfo/g' ext/pcre/pcrelib/pcre_info.c > temp
    mv temp ext/pcre/pcrelib/pcre_info.c
fi

if [ ! -f "$DIR/configure" ]; then
    ./buildconf --force # build configure, not included in git versions
fi

./configure ${PHP_CONF} \
    --disable-cgi \
    --with-readline \
    --enable-pcntl \
    --enable-cli \
    --with-pear \
    --enable-fpm \
    --with-fpm-user=gedi \
    --with-fpm-group=users \
    ${EXT_CONF}
make

