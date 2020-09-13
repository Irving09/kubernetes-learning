#!/usr/bin/env bash
minikube service --url hello-springboot > springboot-log.txt 2>&1 &
sleep 5
SERVICE_URL=$(sed '7q;d' springboot-log.txt)

echo $SERVICE_URL

while sleep 1; 
do 
  curl $SERVICE_URL/hello
  curl $SERVICE_URL/helloNode;
done