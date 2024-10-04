$APPINSIGHTS_NAME = $args[0]

# Create Application Insights instance
az monitor app-insights component create `
--resource-group $RESOURCE_GROUP `
--location $LOCATION `
--app $APPINSIGHTS_NAME `
--workspace $ANALYTICS_WORKSPACE_NAME

