#!/bin/bash

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube

helm repo update

kubectl create namespace sonarqube

export MONITORING_PASSCODE="NotEnabled"

helm upgrade --install -n sonarqube --version '2025.1.0' sonarqube sonarqube/sonarqube --set community.enabled=true,service.type=LoadBalancer,monitoringPasscode=$MONITORING_PASSCODE