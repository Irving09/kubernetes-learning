#!/usr/bin/env bash
COMMIT_NUMBER=$(git rev-parse --short HEAD)
DOCKER_HUB_IMAGE_TAG=innoirvingdev/hello-nodejs:$COMMIT_NUMBER
DOCKER_HUB_IMAGE_TAG_LATEST=innoirvingdev/hello-nodejs:green

docker build -t $DOCKER_HUB_IMAGE_TAG .
docker build -t $DOCKER_HUB_IMAGE_TAG_LATEST .

docker push $DOCKER_HUB_IMAGE_TAG
echo "Image '$DOCKER_HUB_IMAGE_TAG' pushed DockerHUB"

docker push $DOCKER_HUB_IMAGE_TAG_LATEST
echo "Image '$DOCKER_HUB_IMAGE_TAG_LATEST' pushed DockerHUB"
