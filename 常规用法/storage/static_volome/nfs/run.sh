#! /usr/bin/env bash

kubectl create -f nfs_pv.yaml
kubectl create -f ./nfs_pvc.yaml
kubectl create -f ./nfs_pvc_pod.yaml