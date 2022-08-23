#! /usr/bin/env bash

kubectl delete -f ./nfs_pvc_pod.yaml
kubectl delete -f ./nfs_pvc.yaml
kubectl delete -f nfs_pv.yaml

kubectl delete events --all