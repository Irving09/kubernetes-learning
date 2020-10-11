#!/usr/bin/env bash
echo "***************************************************"
echo "Booting up the kubernetes cluster using hyperkit vm"
echo "***************************************************"
minikube start --kubernetes-version=v1.16.0 --memory 8192 --cpus 4 --driver hyperkit --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook
minikube addons enable ingress
minikube addons enable metrics-server

echo "*************************************************"
echo "Configuring the cluster to inject sidecar proxies"
echo "*************************************************"
istioctl install --set profile=demo
kubectl label namespace default istio-injection=enabled
kubectl get namespaces --show-labels
istioctl version

echo "**************************************"
echo "Installing applications on the cluster"
echo "**************************************"
cd k8s
helm install hello-kubernetes hello-kubernetes
helm install ingress ingress
