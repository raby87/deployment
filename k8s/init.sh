#!/bin/sh

kubectl create -f nginx.yaml
kubectl get pod

#kubectl exec -it [pod_id] -- /bin/sh

#kubectl delete -f nginx.yaml
