#!/usr/bin/env bash
minikube service --url hello-nodejs > nodejs-log.txt 2>&1 &
sleep 5
SERVICE_URL=$(minikube ip)

echo $SERVICE_URL

while sleep 1; 
do 
  curl $SERVICE_URL:30081/hello
done