#! /usr/bin/env bash

kubectl delete -f ./fluentd.yaml
kubectl delete -f ./kibana.yaml

kubectl delete -f ./elasticsearch_statefulset.yaml
kubectl delete -f ./nfs-pv.yaml
kubectl delete -f ./elasticsearch_svc.yaml

kubectl delete -f ./kube-logging.yaml
kubectl delete events --all --namespace=kube-logging