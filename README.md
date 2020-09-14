# Prerequisites
- minikube
- helm
- kubectl
- istioctl

## Istio installation
```
curl -L https://istio.io/downloadIstio | sh -
mv istio-1.7.1 /usr/local/bin
echo "export PATH=${PATH}:/usr/local/bin/istio-1.7.1/bin" >> ~/.bash_profile
echo "export PATH=${PATH}:/usr/local/bin/istio-1.7.1/bin" >> ~/.zhrc
source ~/.bash_profile
source ~/.zhrc
istioctl version
istioctl install
```

## Starting the cluster
```
minikube start --memory 4096 --cpus 4 --driver=hyperkit
minikube addons enable metrics-server
minikube addons enable ingress
```

## Configuring the cluster to inject sidecar proxies
```
k label namespace default istio-injection=enabled
```

## Install both applications in local cluster
```
cd k8s
helm install hello-springboot ./hello-kubernetes
helm install hello-nodejs ./hello-kubernetes
helm install ingress ./ingress
```

## Running a NodeJS and Springboot app in kubernetes
`minikube ip`
>192.168.64.6

Copy the above ip in /etc/hosts file and add the following key value pair
```
192.168.64.6 innowashere.com
```

```
curl http://innowashere.com/springboot/hello (spring boot app)
curl http://innowashere.com/springboot/helloNode (spring boot talking to nodejs app)
curl http://innowashere.com/nodejs/hello (nodejs app)
```

### Install the latest version of Kiali Server using a Helm Chart
```
helm install \
  --namespace istio-system \
  --set auth.strategy="anonymous" \
  --repo https://kiali.org/helm-charts \
  kiali-server \
  kiali-server
```