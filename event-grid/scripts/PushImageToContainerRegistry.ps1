$IMAGE_NAME= $args[0]
$IMAGE_DOCKER_FILE= $args[1]

az acr build `
--registry $AZURE_CONTAINER_REGISTRY_NAME `
--image $IMAGE_NAME `
--file $IMAGE_DOCKER_FILE .

#.\scripts\PushImageToContainerRegistry.ps1 <image-name> <Path-to-docker-fiel>
# <image-name> has to be smallcase
