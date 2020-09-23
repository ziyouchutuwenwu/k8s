#! /usr/bin/env bash

helm install elasticsearch --namespace=logs ./elasticsearch
helm install kibana --namespace=logs ./kibana
helm install filebeat  --namespace=logs ./filebeat