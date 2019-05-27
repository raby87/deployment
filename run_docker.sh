#!/bin/bash
product_dir=/www/product-api

docker stop c_api
docker rm c_api
docker build -t api .

docker run --name c_api -p 8082:81 -v ${product_dir}:${product_dir}  -d api 

docker exec -it c_api /bin/sh

#在主机上执行docker容器里面的脚本命令：docker exec -i 容器ID 命令
#如：docker exec -i c_api bash ldapbakup.sh
