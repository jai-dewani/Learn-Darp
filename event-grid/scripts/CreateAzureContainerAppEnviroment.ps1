
$ACA_ENVIRONMENT_NAME = $args[0]

az containerapp env create `
--name $ACA_ENVIRONMENT_NAME `
--resource-group $RESOURCE_GROUP `
--location $LOCATION `
--logs-workspace-id $WORKSPACE_ID `
--logs-workspace-key $WORKSPACE_SECRET `
--dapr-instrumentation-key $APPINSIGHTS_INSTRUMENTATIONKEY `
--enable-workload-profiles `
--infrastructure-subnet-resource-id $ACA_ENVIRONMENT_SUBNET_ID

Set-Variable -Scope Global -Name ACA_ENVIRONMENT_NAME -Value $ACA_ENVIRONMENT_NAME
