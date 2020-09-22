#! /usr/bin/env bash

kubectl delete -f ./storage-class.yaml
kubectl delete -f ./provisioner-deployment.yaml
kubectl delete -f ./test-pod.yaml
# kubectl delete -f ./rbac.yaml

kubectl delete pv --all
kubectl delete pvc --all
