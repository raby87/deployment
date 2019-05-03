#!/bin/sh
ip=192.168.0.167:8081

wget https://toranproxy.com/releases/toran-proxy-v1.3.2.tgz

tar zxvf toran-proxy-v1.3.2.tgz

cp app/config/parameters.yml.dist app/config/parameters.yml

php app/console --help

php app/console server:run -e prod ${ip}

mkdir -p web/repo/packagist/p


php bin/cron -v

curl http://${ip}/


