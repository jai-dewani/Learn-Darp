$ANALYTICS_WORKSPACE_NAME = $args[0]

# Create the Log Analytics workspace
az monitor log-analytics workspace create `
--resource-group $RESOURCE_GROUP `
--workspace-name $ANALYTICS_WORKSPACE_NAME