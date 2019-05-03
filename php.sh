#!/bin/bash
varsion=7.2.4

wget -c http://cn2.php.net/distributions/php-${varsion}.tar.gz

tar -xzvf php-${varsion}.tar.gz

yum install -y 
libxml2*
openssl*
libcurl*
libjpeg*
libpng*
freetype*
libmcrypt*

cd php-${varsion}

./configure --prefix=/mnt/php7 --with-mysqli --with-pdo-mysql --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir --enable-simplexml --enable-xml --disable-rpath --enable-bcmath --enable-soap --enable-zip --with-curl --enable-fpm --with-fpm-user=www --with-fpm-group=www --enable-mbstring --enable-sockets --with-gd --with-openssl --with-mhash --enable-opcache --disable-fileinfo

make && make install
