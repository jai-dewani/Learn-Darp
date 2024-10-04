# Overview 

Here we are trying to achive an inter-process communication line using event-grid. 
Instead of connected our applications directly to event-grid, we are putting this responibility to Dapr. 

Major things I noticed
- For receiving events to an application, Dapr needs to make changes to the event-grid itself i.e. adding an subscription. This requires us to grant access for the same to the Dapr process by passing these values 
```
    - name: azureTenantId  
    value: "<tenant-id>"
    - name: azureSubscriptionId  
    value: "<subscription-id>"
    - name: azureClientId  
    value: "<client-id>"
    - name: azureClientSecret  
    value: "<client-secret"
    - name: direction  
    value: "input"
```
- For publisheding events, we only need a connection string and an accessKey which is the standard amount of information required even if you want to publish an event via a HTTP call. 
```
    - name: accessKey  
    value: "<access-key>"
    - name: topicEndpoint  
    value: "/<topic-endpoint>"
    - name: direction  
    value: "output"
```


## Exact steps to be followed

**Steps to create a Azure Container Infrastructure**

```
az acr create `
--name $AZURE_CONTAINER_REGISTRY_NAME `
--resource-group $RESOURCE_GROUP `
--sku Basic `
--admin-enabled true
```
`AZURE_CONTAINER_REGISTRY_NAME` needs to be all lowercase

--admin-enabled flag set to true which is not suited for real production, but good for my testing enviroment.

**Steps to create a build and push it to azure container registry**
```
az acr build `
--registry $AZURE_CONTAINER_REGISTRY_NAME `
--image $IMAGE_NAME `
--file $IMAGE_DOCKER_FILE .
```
.\scripts\PushImageToContainerRegistry.ps1 <image-name> <Path-to-docker-fiel>  
<image-name> has to be smallcase

## Steps to create a Analytics workspace

```
$ANALYTICS_WORKSPACE_NAME = $args[0]

## Create the Log Analytics workspace
az monitor log-analytics workspace create `
--resource-group $RESOURCE_GROUP `
--workspace-name $ANALYTICS_WORKSPACE_NAME

# Retrieve the Log Analytics workspace ID
$WORKSPACE_ID=az monitor log-analytics workspace show `
--resource-group $RESOURCE_GROUP `
--workspace-name $ANALYTICS_WORKSPACE_NAME `
--query customerId `
--output tsv

Set-Variable -Scope Global -Name ANALYTICS_WORKSPACE_ID -Value $WORKSPACE_ID
Write-Output $WORKSPACE_ID
```

## Create App insight component
```
.\scripts\CreateAppInsightsComponent.ps1 LearnDaprAppInsightsComponent
```

## Get Azure App Insigts Instrumentation Key 
```
.\scripts\GetAzureAppInsigtsInstrumentationKey.ps1 LearnDaprAppInsightsComponent

$APPINSIGHTS_INSTRUMENTATIONKEY
```

## Setup VNet 
```
.\scripts\SetupSubnet.ps1 LearnDaprVNet

$ACA_ENVIRONMENT_SUBNET_ID
```

## Create Container App Enviroment

```
.\scripts\CreateAzureContainerAppEnviroment.ps1 LearnDaprAzureContainerAppEnviroment-eastus
```

## Deploy a Container app to Container Enviroment 
```
.\scripts\CreateAzureContainerApp.ps1 eventgrid-processor-aca-eastus eventgrid/processor:v1 8080
```

## Add Event Grid Dapr Bindings to Azure Container Apps Enviroment 
```
.\scripts\AddEventGridToACA.ps1 .\components\processEvent.yaml
```