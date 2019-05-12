#! /usr/bin/env bash
kubectl create -f nfs-pv.yaml
kubectl create -f ./nfs-pvc.yaml
kubectl create -f ./nfs-pvc-pod.yaml