#!/usr/bin/env bash
MINIKUBE_IP=$(minikube ip)
INGRESS_GATEWAY_PORT=$(kubectl get svc -n istio-system | grep istio-ingressgateway | sed -e 's/\(.*\)80://' | sed -e 's/\/TCP\(.*\)//')
ENDPOINT="http://$MINIKUBE_IP:$INGRESS_GATEWAY_PORT"
echo "starting load test - $ENDPOINT"

while sleep 1; 
do 
  curl $ENDPOINT/nodejs/hello
  curl $ENDPOINT/nodejs/hi
  curl $ENDPOINT/springboot/
  curl $ENDPOINT/springboot/hello
done