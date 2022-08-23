#! /usr/bin/env bash

kubectl delete -f ./demo_sts.yaml
kubectl delete -f ./storage_class.yaml
kubectl delete -f ./nfs_client_provisioner.yaml

kubectl delete pv --all
kubectl delete pvc --all

kubectl delete -f ./nfs_client_provisioner_rbac.yaml
kubectl delete -f ./demo_namespace.yaml