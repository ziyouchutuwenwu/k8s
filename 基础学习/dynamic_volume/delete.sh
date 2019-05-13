#! /usr/bin/env bash

kubectl delete -f ./nfs-storage-class.yaml
kubectl delete -f ./nfs-provisioner-deployment.yaml
kubectl delete -f ./nfs-client-sa.yaml