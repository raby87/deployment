#!/bin/sh

v=4.2.0

wget https://pecl.php.net/get/redis-$v.tgz

tar -xzvf redis-$v.tgz
cd redis-$v


/usr/local/php/bin/phpize
./configure  --with-php-config=/usr/local/php/bin/php-config

make && make install
ls -al  /usr/local/php/lib/php/extensions/no-debug-non-zts-20170718/redis.so

echo "extension=redis.so">>/etc/php.ini
