$YAML = $args[0]

az containerapp env dapr-component set `
--name $ACA_ENVIRONMENT `
--resource-group $RESOURCE_GROUP `
--dapr-component-name statestore `
--yaml $YAML