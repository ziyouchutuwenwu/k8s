#! /usr/bin/env bash

kubectl create -f ./demo_namespace.yaml
kubectl create -f ./rbac.yaml

kubectl create -f ./provisioner_deployment.yaml
kubectl create -f ./storage_class.yaml
kubectl create -f ./demo_sts.yaml