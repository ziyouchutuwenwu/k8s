#! /usr/bin/env bash

kubectl delete -f ./demo_sts.yaml
kubectl delete -f ./storage_class.yaml
kubectl delete -f ./provisioner_deployment.yaml

kubectl delete pv --all
kubectl delete pvc --all

kubectl delete -f ./rbac.yaml
kubectl delete -f ./demo_namespace.yaml