#! /usr/bin/env bash

kubectl delete -f ./pod.yaml
kubectl delete -f ./bind.yaml
kubectl delete -f ./role.yaml

kubectl delete ns mynamespace