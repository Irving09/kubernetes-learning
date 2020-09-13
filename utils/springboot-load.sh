#!/usr/bin/env bash
minikube service --url hello-springboot > springboot-log.txt 2>&1 &
sleep 5
SERVICE_URL=$(minikube ip)

echo $SERVICE_URL

while sleep 1; 
do 
  curl $SERVICE_URL:30080/hello
  curl $SERVICE_URL:30080/helloNode;
done