#!/usr/bin/env bash
minikube start --kubernetes-version=v1.19.1 --memory=10g --cpus 4 --driver=hyperkit --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook
minikube addons enable ingress
kubectl label namespace default istio-injection=enabled
istioctl install
helm install prometheus bitnami/prometheus-operator
helm install hello-springboot ./k8s/hello-kubernetes
helm install hello-nodejs ./k8s/hello-kubernetes
helm install ingress ./k8s/ingress
MINIKUBE_IP=$(minikube ip)
echo "adding '$MINIKUBE_IP innowashere.com' to /etc/hosts"
sudo sed -i -e "15s/.*/$MINIKUBE_IP innowashere.com/" /etc/hosts
