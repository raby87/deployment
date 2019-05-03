#!/bin/bash
product_dir=/www/product-api

docker stop c_api
docker rm c_api
docker build -t api .

docker run --name c_api -d -p 8082:81 -v ${product_dir}:${product_dir} /bin/bash

docker run -it c_api /bin/sh
