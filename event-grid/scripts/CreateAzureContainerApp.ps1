$CONTAINER_NAME = $args[0]
$CONTAINER_IMAGE_NAME = $args[1]
$TARGET_PORT = $args[2]

az containerapp create `
--name $CONTAINER_NAME `
--resource-group $RESOURCE_GROUP `
--environment $ACA_ENVIRONMENT_NAME `
--image "$AZURE_CONTAINER_REGISTRY_NAME.azurecr.io/$CONTAINER_IMAGE_NAME" `
--registry-server "$AZURE_CONTAINER_REGISTRY_NAME.azurecr.io" `
--target-port $TARGET_PORT `
--ingress 'external' `
--min-replicas 1 `
--max-replicas 1 `
--cpu 0.25 `
--memory 0.5Gi