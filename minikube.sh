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
istioctl install
kubectl label namespace default istio-injection=enabled
kubectl get namespaces --show-labels
istioctl version

cd k8s

echo "**************************************"
echo "Installing applications on the cluster"
echo "**************************************"
helm install hello-kubernetes hello-kubernetes
helm install ingress ingress

echo "*******************************************"
echo "Installing Jaeger for Observability Metrics"
echo "*******************************************"
kubectl create namespace observability
kubectl apply -f ./jaeger/jaegertracing.io_jaegers_crd.yaml -n observability
kubectl apply -f ./jaeger/service_account.yaml -n observability
kubectl apply -f ./jaeger/role.yaml -n observability
kubectl apply -f ./jaeger/role_binding.yaml -n observability
kubectl apply -f ./jaeger/operator.yaml -n observability
sleep 5
kubectl apply -f ./jaeger/cluster_role.yaml -n observability
kubectl apply -f ./jaeger/cluster_role_binding.yaml -n observability
sleep 5
kubectl apply -f ./jaeger/jaeger-instance.yaml -n observability

# Above files are taken from here
# https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/crds/jaegertracing.io_jaegers_crd.yaml
# https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/service_account.yaml
# https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/role.yaml
# https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/role_binding.yaml
# https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/operator.yaml
# https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/cluster_role.yaml
# https://raw.githubusercontent.com/jaegertracing/jaeger-operator/master/deploy/cluster_role_binding.yaml
# More info can be seen here: https://github.com/jaegertracing/jaeger-operator