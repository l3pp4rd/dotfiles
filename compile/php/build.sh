#!/bin/sh

# For ArchLinux environment

DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ $# -lt 1 ] ; then
    echo -e "Wrong number of parameters."
    echo -e "Usage:"
    echo -e " build\n 'source' - php source directory, etc.: '~/php/php-5.4'\n"
    echo -e " run make install afterwards, or make test first\n"
    exit 0
fi

if [ ! -d "$1" ]
then
    echo "Php source is not a valid directory"
    exit 1
fi

CONF="--prefix=/usr \
    --localstatedir=/var \
    --with-layout=GNU \
    --sysconfdir=/etc/php \
    --with-config-file-path=/etc/php \
    --with-config-file-scan-dir=/etc/php/conf.d \
    --mandir=/usr/share/man \
    --enable-calendar \
    --enable-exif \
    --enable-ftp \
    --enable-mbstring \
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
    --with-snmp=/usr \
    --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=shared,/usr \
    --with-freetype-dir=/usr \
    --with-bz2=/usr \
    --with-gettext \
    --with-iconv-dir=/usr \
    --with-mcrypt=/usr \
    --with-mhash \
    --with-mysql-sock=/var/run/mysqld/mysqld.sock \
    --with-mysql=/usr \
    --with-mysqli=mysqlnd \
    --with-openssl \
    --with-openssl-dir=/usr/bin \
    --with-zlib-dir=/usr \
    --with-xpm-dir=/usr \
    --with-pcre-regex=/usr \
    --with-pdo-mysql=/usr \
    --with-pdo-pgsql=/usr \
    --with-pgsql=/usr \
    --with-regex=php \
    --with-pspell \
    --with-sqlite3=/usr \
    --with-pdo-sqlite=/usr \
    --with-tidy=/usr \
    --with-xmlrpc \
    --with-xsl=/usr \
    --enable-pcntl \
    --with-pear \
    --enable-cli \
    --enable-fpm \
    --with-fpm-user=http \
    --with-fpm-group=http \
    --disable-debug
"

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
./configure ${CONF}
make

