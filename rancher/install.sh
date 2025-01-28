#!/bin/sh

RANCHER_VERSION="2.10.2"

subdomain="rancher.${CLUSTER_ID}.k8s.civo.com"
email="${EMAIL}"
echo "$subdomain"
echo "${EMAIL}"
#Wait for the Cert Manager deployment to be done.
if kubectl get ns | grep -q cert-manager; then
    echo "cert-manager namespace exists, proceeding to next command..."
    # Place your next command here
else
    sleep 10
fi

kubectl wait --for=condition=available --timeout=300s deployment/cert-manager-webhook  -n cert-manager

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update
kubectl create namespace cattle-system

  
helm upgrade --install rancher rancher-latest/rancher --namespace cattle-system --set hostname="$subdomain" --set bootstrapPassword="${ADMIN_PASS}" --set ingress.tls.source=letsEncrypt --set letsEncrypt.ingress.class=traefik --set letsEncrypt.email="${EMAIL}" --version "$RANCHER_VERSION"
