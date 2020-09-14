#!/usr/bin/env bash
minikube start --kubernetes-version=v1.19.1 --memory=10g --cpus 4 --driver=hyperkit --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook
minikube addons enable ingress
minikube addons enable metrics-server
kubectl label namespace default istio-injection=enabled
kubectl get namespaces --show-labels
istioctl install
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/prometheus.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/kiali.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/grafana.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/jaeger.yaml
helm install hello-springboot ./k8s/hello-kubernetes
helm install hello-nodejs ./k8s/hello-kubernetes
helm install ingress ./k8s/ingress
MINIKUBE_IP=$(minikube ip)
echo "adding '$MINIKUBE_IP innowashere.com' to /etc/hosts"
sudo sed -i -e "15s/.*/$MINIKUBE_IP innowashere.com/" /etc/hosts
