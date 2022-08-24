#! /usr/bin/env bash

kubectl create ns mynamespace

kubectl create -f ./role.yaml
kubectl create -f ./bind.yaml
kubectl create -f ./pod.yaml