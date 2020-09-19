#!/usr/bin/env bash

echo "Booting up the kubernetes cluster using hyperkit vm"
minikube start --kubernetes-version=v1.16.0 --memory=10g --cpus 4 --driver=hyperkit --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook
minikube addons enable ingress
minikube addons enable metrics-server

echo "Configuring the cluster to inject sidecar proxies"
istioctl version
kubectl label namespace default istio-injection=enabled
kubectl get namespaces --show-labels
/usr/local/bin/istio-1.5.4/bin/istioctl manifest apply --set profile=demo

echo "Install prometheus/kiali/grafana/jaeger addons on the cluster"
# kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/prometheus.yaml
# kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/kiali.yaml
# kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/grafana.yaml
# kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/jaeger.yaml

echo "Installing applications on the cluster"
cd k8s
helm install springboot hello-nodejs
helm install nodejs hello-springboot
helm install ingress ingress

# This is for non-istio ingress
#MINIKUBE_IP=$(minikube ip)
#echo "adding '$MINIKUBE_IP innowashere.com' to /etc/hosts"
#sudo sed -i -e "15s/.*/$MINIKUBE_IP innowashere.com/" /etc/hosts
