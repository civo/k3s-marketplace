#!/bin/bash

# create the definitions of custom resources before they're needed
kubectl apply -f crds

# install everything remaining including custom resources
kubectl apply -f manifests
