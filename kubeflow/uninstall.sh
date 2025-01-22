#!/bin/bash

# uninstall everything remaining including custom resources
kubectl delete -f manifests

# delete the definitions of custom resources before they're needed
kubectl delete -f crds
