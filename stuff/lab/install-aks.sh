#"deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
#sudo apt update
#sudo apt install azure-cli

##Build time
  resource_group_name="rg"
  resource_group_location="ukwest"
  aks_cluster_name="cluster01"

  function_create_resource_group () {
    azure-cli group create --location $resource_group_location \
                           --name $resource_group_name
                              #  [--subscription]
                              #  [--tags]
                            }

  function_create_aks_cluster () {
    azure-cli aks create --name $aks_cluster_name \
                       --resource-group $resource_group_name \
                       --generate-ssh-keys \
                       --node-count 2
                     }
  function_map_k8_creds () {
    azure-cli aks get-credentials --name 'MyManagedCluster' \
                                  --resource-group $resource_group_name
                                  }
## Run time
  function_create_resource_group
  function_create_aks_cluster
  function_map_k8_creds

  azure-cli group list
