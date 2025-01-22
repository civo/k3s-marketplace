#!/bin/bash

echo "Adding Apache Superset Helm repository..."
helm repo add superset https://apache.github.io/superset
if [ $? -eq 0 ]; then
    echo "Successfully added Superset Helm repository."
else
    echo "Failed to add Superset Helm repository. Exiting."
    exit 1
fi

echo "Updating Helm repositories..."
helm repo update
if [ $? -eq 0 ]; then
    echo "Helm repositories updated successfully."
else
    echo "Failed to update Helm repositories. Exiting."
    exit 1
fi

echo "Creating 'superset' namespace..."
kubectl create namespace superset
if [ $? -eq 0 ]; then
    echo "Namespace 'superset' created successfully."
else
    echo "'superset' namespace may already exist or there was an error creating it."
fi

echo "Searching for Superset chart in the repository..."
helm search repo superset
if [ $? -eq 0 ]; then
    echo "Superset chart found."
else
    echo "Superset chart not found. Please check the repository and try again."
    exit 1
fi

echo "Installing or upgrading Superset with provided values..."
helm upgrade --install --values values.yaml superset superset/superset -n superset
if [ $? -eq 0 ]; then
    echo "Superset installation/upgrade completed successfully."
else
    echo "Failed to install/upgrade Superset. Exiting."
    exit 1
fi

echo "To check the status of the Superset pods, run the following command:"
echo "  kubectl get pods -n superset"
echo ""
echo "To access the Superset service, use port forwarding with the command:"
echo "  kubectl port-forward service/superset 8088:8088 --namespace superset"
echo ""
echo "You can access the Superset application by opening your browser and visiting:"
echo "  http://localhost:8088"
echo ""
echo "Default login credentials:"
echo "------Username: admin-----"
echo "------Password: admin-----"
echo "It is highly recommended to change these credentials after the first login :)"
