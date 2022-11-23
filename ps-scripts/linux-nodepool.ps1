# setting variables from variable file
Write-Host "Loading variables from .\vars.txt" -ForegroundColor Yellow
Foreach ($i in $(Get-Content vars.txt)){Set-Variable -Name $i.split("=")[0] -Value $i.split("=").split(" ")[1]}

$subscriptionId = (az account show | ConvertFrom-Json).id
$tenantId = (az account show | ConvertFrom-Json).tenantId
Write-Host "Subscription Id: $subscriptionId, Tenant Id: $tenantId" -ForegroundColor Green

# Add a Linux nodepool

Write-Host "Adding a Linux node pool" -ForegroundColor Yellow

az aks nodepool add `
    --resource-group $resourceGroup `
    --cluster-name $clusterName `
    --name linuxnp `
    --node-count 2

# For Marina
# az aks nodepool add `
#     --resource-group myResourceGroup `
#     --cluster-name myAKSCluster `
#     --os-sku CBLMariner `
#     --node-count 2
