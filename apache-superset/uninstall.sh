#!/bin/bash
# Superset Uninstallation Script
helm uninstall superset --namespace superset
kubectl delete namespace superset
