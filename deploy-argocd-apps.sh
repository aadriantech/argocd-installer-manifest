#!/bin/bash

# Ensure script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Array of manifest files
manifests=("argocd-metallb.yaml" "argocd-kong.yaml" "argocd-capstone-vulnerable-php83.yaml")

# Loop through each manifest file and apply it
for manifest in "${manifests[@]}"; do
  echo "Applying ArgoCD Application for $manifest..."
  kubectl apply -f "$manifest"

  # Check if the previous command was successful
  if [ $? -ne 0 ]; then
    echo "Failed to apply $manifest"
    exit 1
  fi
done

echo "Successfully applied all ArgoCD Applications"
