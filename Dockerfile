FROM centos:7
MAINTAINER raby <1818@skiy.net>


ENV NGINX_VERSION 1.16.0
ENV PHP_VERSION 7.2.18

COPY start.sh /www/start.sh
ENTRYPOINT ["/www/start.sh"]
