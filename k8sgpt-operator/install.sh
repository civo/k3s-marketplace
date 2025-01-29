#!/bin/bash

helm repo add k8sgpt https://charts.k8sgpt.ai/
helm repo update k8sgpt
helm install k8sgpt-operator k8sgpt/k8sgpt-operator -n k8sgpt-operator-system --create-namespace --version 0.1.4
