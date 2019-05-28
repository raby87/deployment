#!/bin/sh

php_dir=/php-7.2.17

cd $php_dir/ext/pdo_mysql

/usr/local/php/bin/phpize
./configure

make && make install


ls -al  /usr/local/php/lib/php/extensions/no-debug-non-zts-20170718/pdo_mysql.so

echo "extension=pdo_mysql.so">>/etc/php.ini
