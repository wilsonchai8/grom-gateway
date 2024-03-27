FROM openresty/openresty:1.19.9.1-centos
ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD conf.d /etc/nginx/conf.d
ADD dist /usr/local/openresty/nginx/html
ADD lua /usr/local/openresty/nginx/lua
ADD lib /usr/local/openresty/nginx/lib/resty
