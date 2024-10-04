$ANALYTICS_WORKSPACE_NAME = $args[0]

# Retrieve the Log Analytics workspace ID
$WORKSPACE_ID=az monitor log-analytics workspace show `
--resource-group $RESOURCE_GROUP `
--workspace-name $ANALYTICS_WORKSPACE_NAME `
--query customerId `
--output tsv

Write-Output $WORKSPACE_ID
Set-Variable -Scope Global -Name ANALYTICS_WORKSPACE_ID -Value $WORKSPACE_ID

# Retrieve the Log Analytics workspace secret
$WORKSPACE_SECRET=az monitor log-analytics workspace get-shared-keys `
--resource-group $RESOURCE_GROUP `
--workspace-name $ANALYTICS_WORKSPACE_NAME `
--query primarySharedKey `
--output tsv

Write-Output $WORKSPACE_SECRET
Set-Variable -Scope Global -Name ANALYTICS_WORKSPACE_SECRET -Value $WORKSPACE_SECRET