#!/bin/sh


yum install -y etcd
yum -y install kubernetes


rpm  -e --nodeps  subscription-manager-rhsm-certificates-1.21.10-3.el7.centos.x86_64

wget  http://mirror.centos.org/centos/7/os/x86_64/Packages/python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm


rpm -ivh python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm
