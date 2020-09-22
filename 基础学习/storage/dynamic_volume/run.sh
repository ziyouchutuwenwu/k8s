#! /usr/bin/env bash

# kubectl create -f ./rbac.yaml
kubectl create -f ./provisioner-deployment.yaml
kubectl create -f ./storage-class.yaml
kubectl create -f ./test-pod.yaml