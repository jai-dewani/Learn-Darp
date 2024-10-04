az acr create `
--name $AZURE_CONTAINER_REGISTRY_NAME `
--resource-group $RESOURCE_GROUP `
--sku Basic `
--admin-enabled true