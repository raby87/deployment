#!/bin/bash
product=api

docker stop c_$product
docker rm c_$product
docker build -t $product .

docker run --name c_$product -p 8082:80 -v /www/${product_dir}:/www  -d $product  --privileged=true
#docker run --name c_api -p 8082:80 -v /www/${product_dir}:/www -d api /bin/sh -c "sleep 1000000000"

docker exec -it c_$product /bin/sh

#在主机上执行docker容器里面的脚本命令：docker exec -i 容器ID 命令
#如：docker exec -i c_api bash ldapbakup.sh
