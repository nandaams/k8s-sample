> Adopted from https://github.com/MicrosoftDocs/mslearn-dotnet-kubernetes

# Setup Guide

The .NET apps can run on either Linux or Windows (since it's .NET Core). However, for this guide, we will focus mainly on Windows platform.

### Pre-requisite
- The following tools are installed on your Windows dev machine: 
    - [_Docker desktop_](https://docs.docker.com/desktop/install/windows-install/)
    - [_Azure CLI_](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)
    - Azure subscription with a few credits, [see how to get free monthly credits here](https://azure.microsoft.com/en-us/pricing/member-offers/credit-for-visual-studio-subscribers/).
- This example was run on, but not limited to _Windows 10, 21 H2_.

### Build the images

- `git clone git@github.com:nandaams/dotnet-kubernetes.git`
- `cd` into `dotnet-kubernetes` directory
- Make sure your Docker desktop is running
- run: `docker-compose build`
- Test locally: `docker-compose up`
- The front end should be accessed at `http://localhost:5092`

### Upload the images to Docker Hub

Login into docker:
```
docker login
```

Retag the images:
```
docker tag pizzafrontend [YOUR DOCKER USER NAME]/pizzafrontend
docker tag pizzabackend [YOUR DOCKER USER NAME]/pizzabackend
```

### Create AKS Cluster

> _Run all this from Powershell_

- `az login` (if you have multiple subscriptions, make sure you have the right subscription set as default.)
- `cd` into `ps-scripts`
- Update `vars.txt`
- Run `.\aks-create.ps1` - the script create an AKS cluster, adds a Windows node pool and connects to the cluster.

### Deploy the application

- Shortcut: while still in `ps-scripts` directory, you can just run `.\deploy.ps1` OR
- `cd` into `deployment-files` directory.
- Run `kubectl apply -f .`
- After a few minutes, if you run `kubectl get services`, you should get something similar to:

```
NAME            TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
kubernetes      ClusterIP      10.0.0.1      <none>          443/TCP        36m
pizzabackend    ClusterIP      10.0.253.68   <none>          80/TCP         8m7s
pizzafrontend   LoadBalancer   10.0.191.38   4.236.217.199   80:30172/TCP   6m19s
```

- Access the frontend with the given external IP: `http://EXTERNAL-IP`, e.g. `http://4.236.217.199`

### Clean-up
Clean up by deleting the resource group, in `ps-scripts`, run: `.\clean-up.ps1`

### TODO

- [ ] remove unused namespaces in .cs files
- [ ] add Log Monitor
- [ ] connect to Azure Monitor or ELK logging stack

## References

- https://learn.microsoft.com/en-us/azure/aks/learn/quick-windows-container-deploy-cli
- https://learn.microsoft.com/en-us/azure/aks/learn/quick-windows-container-deploy-cli

# Legal Notices

Microsoft and any contributors grant you a license to the Microsoft documentation and other content
in this repository under the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/legalcode),
see the [LICENSE](LICENSE) file, and grant you a license to any code in the repository under the [MIT License](https://opensource.org/licenses/MIT), see the
[LICENSE-CODE](LICENSE-CODE) file.

Microsoft, Windows, Microsoft Azure and/or other Microsoft products and services referenced in the documentation
may be either trademarks or registered trademarks of Microsoft in the United States and/or other countries.
The licenses for this project do not grant you rights to use any Microsoft names, logos, or trademarks.
Microsoft's general trademark guidelines can be found at http://go.microsoft.com/fwlink/?LinkID=254653.

Privacy information can be found at https://privacy.microsoft.com/en-us/

Microsoft and any contributors reserve all other rights, whether under their respective copyrights, patents,
or trademarks, whether by implication, estoppel or otherwise.
