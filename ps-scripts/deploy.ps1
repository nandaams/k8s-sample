Write-Host "Loading variables from .\vars.txt" -ForegroundColor Yellow
Foreach ($i in $(Get-Content vars.txt)){Set-Variable -Name $i.split("=")[0] -Value $i.split("=").split(" ")[1]}

Write-Host "Deploying app onto K8s cluster $clusterName" -ForegroundColor Yellow

kubectl apply -f ..\deployment-files
