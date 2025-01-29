#!/bin/bash

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube

helm repo update

kubectl create namespace sonarqube

export MONITORING_PASSCODE="NotEnabled"

helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube --set community.enabled=true,service.type=LoadBalancer,monitoringPasscode=$MONITORING_PASSCODE