#!/bin/bash

NAMESPACE=ngrok-ingress-controller
SECRET_NAME=ngrok-ingress-controller-credentials
VERSION=$(helm search hub ngrok kubernetes-ingress-controller -o json | jq -r '.[0].version')

echo "Enabling ngrok ingress controller in {$NAMESPACE} namespace"

helm repo update ngrok || helm repo add ngrok https://ngrok.github.io/kubernetes-ingress-controller

helm upgrade --install --create-namespace ngrok-ingress-controller ngrok/kubernetes-ingress-controller --namespace "${NAMESPACE}" --set credentials.secret.name="${SECRET_NAME}" --version $VERSION