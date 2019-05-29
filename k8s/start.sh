#!/bin/sh
rm -rf /var/lib/docker/*

systemctl start etcd
systemctl start docker
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy


docker pull registry.access.redhat.com/rhel7/pod-infrastructure:latest

