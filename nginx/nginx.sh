#!/bin/sh

yum -y localinstall http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

yum -y install nginx


service nginx start
