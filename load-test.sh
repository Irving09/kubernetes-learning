#!/usr/bin/env bash
MINIKUBE_IP=$(minikube ip)
echo "starting load test - http://$MINIKUBE_IP:30646/"

while sleep 1; 
do 
  curl http://$MINIKUBE_IP:30646/nodejs/hello
  curl http://$MINIKUBE_IP:30646/springboot/hello
  curl http://$MINIKUBE_IP:30646/springboot/helloNode
done