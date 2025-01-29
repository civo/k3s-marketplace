#!/bin/bash

NS=k8sgpt-operator-system

kubectl config set-context --current --namespace=$NS

# Uninstall chart
helm uninstall k8sgpt-operator

# Delete the namespace
kubectl delete namespace $NS
