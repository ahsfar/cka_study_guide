#!/bin/bash

# Suppose you have three Kubernetes clusters for development, staging, and production 
# Path to the kubeconfig file, ensuring it's securely handled
KUBECONFIG_PATH="~/.kube/config"

# Path to the deployment file
DEPLOYMENT_FILE="deployment.yaml"

# Ensure the kubeconfig file exists and is readable
if [[ ! -r "$KUBECONFIG_PATH" ]]; then
    echo "Error: kubeconfig file not found or not readable."
    exit 1
fi

# Ensure the deployment file exists and is readable
if [[ ! -r "$DEPLOYMENT_FILE" ]]; then
    echo "Error: Deployment file $DEPLOYMENT_FILE not found or not readable."
    exit 1
fi

# Loop through each context in kube_contexts.txt
while read -r context; do
    # Validate if the context exists in the kubeconfig
    if kubectl config get-contexts "$context" > /dev/null 2>&1; then
        echo "Applying deployment to context: $context"
        
        # Attempt to apply the deployment file to the current context
        if ! kubectl --context="$context" apply -f "$DEPLOYMENT_FILE"; then
            echo "Error: Failed to apply deployment to context $context."
            # Consider whether to continue or exit based on your use case
            # exit 1
        fi
    else
        echo "Warning: Context $context not found in kubeconfig."
        # Consider whether to continue or exit based on your use case
        # continue or exit 1
    fi
done < "kube_contexts.txt"
