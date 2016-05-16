#!/bin/bash
# You can override config options very easily.
# Just create a custom options file; it may be version specific:
# - custom-options.sh
# - custom-options-5.sh
# - custom-options-5.3.sh
# - custom-options-5.3.1.sh
#
# Don't touch this file here - it would prevent you to just "svn up"
# your phpfarm source code.

version=$1
vmajor=$2
vminor=$3
vpatch=$4


#--with-gmp=/usr/include/x86_64-linux-gnu \
#configure: error: Unable to locate gmp.h
#

#gcov='--enable-gcov'
configoptions="\
--enable-bcmath \
--enable-debug
--enable-calendar \
--enable-cli \
--enable-gd-native-ttf \
--enable-exif \
--enable-fastcgi \
--enable-fpm \
--enable-ftp \
--enable-gd-native-ttf \
--enable-inline-optimization \
--enable-intl \
--enable-json \
--enable-libxml \
--enable-mbregex \
--enable-mbstring \
--enable-mysql \
--enable-mysqli \
--enable-mysqlnd \
--enable-pcntl \
--enable-pdo \
--enable-posix \
--enable-soap \
--enable-sockets \
--enable-sqlite-utf8 \
--enable-sysvsem \
--enable-sysvshm \
--enable-wddx \
--enable-zip \
--with-bz2 \
--with-curl \
--with-fpm-group=www-data \
--with-fpm-user=www-data \
--with-freetype-dir \
--with-zlib \
--with-gd \
--with-gettext \
--with-jpeg-dir \
--with-mcrypt \
--with-mhash \
--with-mysql \
--with-mysqli \
--with-openssl \
--with-pcre-regex \
--with-pdo-mysql \
--with-pdo-pgsql \
--with-pear \
--with-pgsql \
--with-png-dir \
--with-posix \
--with-vpx-dir \
--with-xmlrpc \
--with-xsl \
--with-zlib \
--with-zlib-dir \
$gcov"

echo $version $vmajor $vminor $vpatch

custom="custom-options.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch
custom="custom-options-$vmajor.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch
custom="custom-options-$vmajor.$vminor.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch
custom="custom-options-$vmajor.$vminor.$vpatch.sh"
[ -f $custom ] && source "$custom" $version $vmajor $vminor $vpatch
