#! /usr/bin/env bash
kubectl delete -f ./nfs-pvc-pod.yaml
kubectl delete -f ./nfs-pvc.yaml
kubectl delete -f nfs-pv.yaml

kubectl delete events --all