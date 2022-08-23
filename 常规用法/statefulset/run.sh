#! /usr/bin/env bash

kubectl create -f ./demo_namespace.yaml
kubectl create -f ./nfs_client_provisioner_rbac.yaml

kubectl create -f ./nfs_client_provisioner.yaml
kubectl create -f ./storage_class.yaml
kubectl create -f ./demo_sts.yaml