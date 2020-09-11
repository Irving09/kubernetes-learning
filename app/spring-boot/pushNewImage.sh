#!/usr/bin/env bash

./gradlew clean build

COMMIT_NUMBER=$(git rev-parse --short HEAD)
DOCKER_HUB_IMAGE_TAG=innoirvingdev/hello-springboot:$COMMIT_NUMBER

docker build -t $DOCKER_HUB_IMAGE_TAG .
docker push $DOCKER_HUB_IMAGE_TAG

echo "New docker image has been pushed to DockerHUB: $DOCKER_HUB_IMAGE_TAG"