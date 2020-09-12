#!/usr/bin/env bash

./gradlew clean build

COMMIT_NUMBER=$(git rev-parse --short HEAD)
DOCKER_HUB_IMAGE_COMMIT_TAG=innoirvingdev/hello-springboot:$COMMIT_NUMBER
DOCKER_HUB_IMAGE_LATEST_TAG=innoirvingdev/hello-springboot:latest

docker build -t $DOCKER_HUB_IMAGE_COMMIT_TAG .
docker push $DOCKER_HUB_IMAGE_COMMIT_TAG
echo "New docker image has been pushed to DockerHUB: $DOCKER_HUB_IMAGE_COMMIT_TAG"

docker build -t $DOCKER_HUB_IMAGE_LATEST_TAG .
docker push $DOCKER_HUB_IMAGE_LATEST_TAG
echo "New docker image has been pushed to DockerHUB: $DOCKER_HUB_IMAGE_LATEST_TAG"