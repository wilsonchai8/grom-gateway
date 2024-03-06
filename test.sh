#!bin/bash

name=grom-gateway
current_dir=`pwd`

docker rm -f $name
docker run -d --restart=always --name=$name \
    -p 9999:80 \
    -v $current_dir/conf.d:/etc/nginx/conf.d \
    -v $current_dir/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
    -v $current_dir/dist:/usr/local/openresty/nginx/html \
    -v $current_dir/lua:/usr/local/openresty/nginx/lua \
    -v $current_dir/lib:/usr/local/openresty/nginx/lib/resty \
    openresty/openresty:1.19.9.1-centos
