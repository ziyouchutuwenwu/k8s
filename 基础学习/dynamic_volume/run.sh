#! /usr/bin/env bash

kubectl create -f ./nfs-client-sa.yaml
kubectl create -f ./nfs-provisioner-deployment.yaml
kubectl create -f ./nfs-storage-class.yaml