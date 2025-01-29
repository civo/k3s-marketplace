#!/bin/sh

KUBEWARDEN_CRDS_CHART_VERSION="1.13.0"
KUBEWARDEN_DEFAULTS_CHART_VERSION="2.8.0"
KUBEWARDEN_CONTROLLER_CHART_VERSION="4.1.0"


# Currently, the chart depends on cert-manager.
# Make sure we have cert-manager installed before installing the kubewarden-controller chart.
kubectl wait --for=condition=Available deployment --timeout=2m -n cert-manager --all

helm repo add kubewarden https://charts.kubewarden.io

helm repo update kubewarden

helm upgrade \
  --install \
  --wait \
  -n kubewarden \
  --version "$KUBEWARDEN_CRDS_CHART_VERSION" \
  --create-namespace \
  kubewarden-crds \
  kubewarden/kubewarden-crds

helm upgrade \
  --install \
  --wait \
  -n kubewarden \
  --version "$KUBEWARDEN_CONTROLLER_CHART_VERSION" \
  kubewarden-controller \
  kubewarden/kubewarden-controller

# WARNING Enforcing the policies to the kube-system namespace could break your cluster.
# Be aware that some pods could need break this rules.
# Therefore, the user must be sure which namespaces the policies will be applied.
# Remember that when you define the --set command line flag the default values are overwritten.
# So, the user must define the kube-system namespace manually.
helm upgrade \
  --install \
  --wait \
  -n kubewarden \
  --version "$KUBEWARDEN_DEFAULTS_CHART_VERSION" \
  --set recommendedPolicies.enabled=True \
  --set recommendedPolicies.skipAdditionalNamespaces[0]="kube-system" \
  --set recommendedPolicies.skipAdditionalNamespaces[1]="cert-manager" \
  kubewarden-defaults \
  kubewarden/kubewarden-defaults

