#!/bin/sh
echo "ONBOOT = yes">> /etc/sysconfig/network-scripts/ifcfg-ens33
service network restart

yum install net-tools
