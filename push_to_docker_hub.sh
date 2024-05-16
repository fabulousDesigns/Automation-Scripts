#!/bin/bash
#? Automate Build & push Docker image to Docker Hub
echo "******************************************************************************************************************************************************"
echo "                                             Docker Image Build & Push Automation Script                                   "
echo "******************************************************************************************************************************************************"
#? This function will create a random Tag for the Docker Image
docker_image_random_tag() {
  echo "v$(date +%s)"
}
read -p "Enter docker hub repository name or continue with a random name: " IMAGE_NAME
[ -z "$IMAGE_NAME" ] 
read -p "Enter Docker Image Tag: " IMAGE_TAG
[ -z "$IMAGE_TAG" ] && IMAGE_TAG=$(docker_image_random_tag)
read -p "Enter Docker Hub Username: " DOCKER_USERNAME
[ -z "$DOCKER_USERNAME" ] && echo "Docker Hub Username is required" && exit 1
read -p "Enter Docker Hub Password: " DOCKER_PASSWORD
[ -z "$DOCKER_PASSWORD" ] && echo "Docker Hub Password is required" && exit 1
echo "******************************************************************************************************************************************************"
echo "                                                   Building Docker Image: $IMAGE_NAME:$IMAGE_TAG                                 "
echo "******************************************************************************************************************************************************"
read -p "would you like to provide a path to Dockerfile? (y/n): " CHOICE    
[ "$CHOICE" == "y" ] && read -p "Enter the path to Dockerfile: " DOCKERFILE_PATH && docker build -t $IMAGE_NAME:$IMAGE_TAG -f $DOCKERFILE_PATH . || docker build -t $IMAGE_NAME:$IMAGE_TAG .
[ $? -ne 0 ] && echo "Failed to build Docker Image: $IMAGE_NAME:$IMAGE_TAG" && exit 1 || echo "Docker Image Built Successfully: $IMAGE_NAME:$IMAGE_TAG"
echo "******************************************************************************************************************************************************"
echo "                         Logging into Docker Hub                                                "
echo "******************************************************************************************************************************************************"
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
[ $? -ne 0 ] && echo "Failed to login to Docker Hub" && exit 1 || echo "Logged in to Docker Hub Successfully"
echo "******************************************************************************************************************************************************"
echo "                     Pushing Docker Image: $IMAGE_NAME:$IMAGE_TAG                               "
echo "******************************************************************************************************************************************************"
docker push $IMAGE_NAME:$IMAGE_TAG
[ $? -ne 0 ] && echo "Failed to push Docker Image: $IMAGE_NAME:$IMAGE_TAG" && exit 1  || echo "Docker Image Pushed Successfully to Docker Hub"
echo "******************************************************************************************************************************************************"
 
