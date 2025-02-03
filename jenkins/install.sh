#!/bin/bash

helm repo add jenkins https://charts.jenkins.io
helm repo update

kubectl create namespace jenkins

helm install jenkins jenkins/jenkins --version 5.8.8 --namespace jenkins --set persistence.size=${VOLUME_SIZE} \
--set controller.admin.username=${JENKINS_USERNAME} \
--set controller.admin.password=${JENKINS_PASSWORD}
