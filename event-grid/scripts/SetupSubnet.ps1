$VNET_NAME = $args[0]

# Create a virtual network
az network vnet create `
--name $VNET_NAME `
--resource-group $RESOURCE_GROUP `
--address-prefix 10.0.0.0/16 `
--subnet-name ContainerAppSubnet `
--subnet-prefix 10.0.0.0/27

# Azure Container Apps requires management of the subnet, so we must delegate exclusive control.
az network vnet subnet update `
--name ContainerAppSubnet `
--resource-group $RESOURCE_GROUP `
--vnet-name $VNET_NAME `
--delegations Microsoft.App/environments

# Retrieve the Azure Container App subnet resource ID
$ACA_ENVIRONMENT_SUBNET_ID=$(az network vnet subnet show `
--name ContainerAppSubnet `
--resource-group $RESOURCE_GROUP `
--vnet-name $VNET_NAME `
--query id `
--output tsv)

Set-Variable -Scope Global -Name ACA_ENVIRONMENT_SUBNET_ID -Value $ACA_ENVIRONMENT_SUBNET_ID
