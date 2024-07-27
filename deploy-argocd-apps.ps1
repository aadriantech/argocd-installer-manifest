# Ensure script is run with administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator"
    exit 1
}

# Array of manifest files
$manifests = @("01-argocd-metallb.yaml", "02-argocd-traefik.yaml")

# Loop through each manifest file and apply it
foreach ($manifest in $manifests) {
    Write-Output "Applying ArgoCD Application for $manifest..."
    #kubectl apply -f $manifest --validate=false
    kubectl apply -f $manifest

    # Check if the previous command was successful
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to apply $manifest"
        exit 1
    }
}

Write-Output "Successfully applied all ArgoCD Applications"
