$APPINSIGHTS_NAME = $args[0]

# Get Application Insights Instrumentation Key
$APPINSIGHTS_INSTRUMENTATIONKEY=($(az monitor app-insights component show `
--resource-group $RESOURCE_GROUP `
--app $APPINSIGHTS_NAME ) | ConvertFrom-Json).instrumentationKey

Set-Variable -Scope Global -Name APPINSIGHTS_INSTRUMENTATIONKEY -Value $APPINSIGHTS_INSTRUMENTATIONKEY
