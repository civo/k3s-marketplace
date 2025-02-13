#!/bin/bash

helm repo add projectsveltos https://projectsveltos.github.io/helm-charts

helm repo update

helm install projectsveltos projectsveltos/projectsveltos -n projectsveltos --create-namespace --version v0.47.0

# If you also want to deploy the dashboard 
helm install sveltos-projectsveltos projectsveltos/sveltos-dashboard -n projectsveltos --version v0.47.0