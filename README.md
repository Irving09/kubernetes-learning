# Prerequisites
- minikube
- helm
- kubectl
- istioctl

## Quick Setup
```
bash ./setup.sh
```

### Istio installation
```
curl -L https://istio.io/downloadIstio | sh -
mv istio-1.7.1 /usr/local/bin
echo "export PATH=${PATH}:/usr/local/bin/istio-1.7.1/bin" >> ~/.bash_profile
echo "export PATH=${PATH}:/usr/local/bin/istio-1.7.1/bin" >> ~/.zhrc
source ~/.bash_profile
source ~/.zhrc
istioctl version
```

### Starting the cluster
```
minikube start --kubernetes-version=v1.19.1 --memory=6g --cpus 4 --driver=hyperkit --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook
minikube addons enable metrics-server
minikube addons enable ingress
```

### Configuring the cluster to inject sidecar proxies
```
k label namespace default istio-injection=enabled
kubectl get namespaces --show-labels
istioctl install
```

### Install prometheus/kiali/grafana/jaeger
```
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/prometheus.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/kiali.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/grafana.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/jaeger.yaml
```

### Install applications in the local cluster
```
cd k8s
helm install hello-springboot ./hello-kubernetes
helm install hello-nodejs ./hello-kubernetes
helm install ingress ./ingress
```

### Running a NodeJS and Springboot app in kubernetes
`minikube ip`
>192.168.64.6

Copy the above ip in /etc/hosts file and add the following key value pair and make sure it matches the ingress gateway's yaml configuration
```
192.168.64.6 innowashere.com
```

```
curl http://innowashere.com/springboot/hello (spring boot app)
curl http://innowashere.com/springboot/helloNode (spring boot talking to nodejs app)
curl http://innowashere.com/nodejs/hello (nodejs app)
```