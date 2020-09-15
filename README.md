# Prerequisites
- minikube
- helm
- kubectl
- istioctl

`minikube version`
>minikube version: v1.13.0
commit: eeb05350f8ba6ff3a12791fcce350c131cb2ff44

`helm version`
>version.BuildInfo{Version:"v3.3.1", GitCommit:"249e5215cde0c3fa72e27eb7a30e8d55c9696144", GitTreeState:"dirty", GoVersion:"go1.15"}

`kubectl version`
>Client Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.1", GitCommit:"206bcadf021e76c27513500ca24182692aabd17e", GitTreeState:"clean", BuildDate:"2020-09-09T19:10:58Z", GoVersion:"go1.15.1", Compiler:"gc", Platform:"darwin/amd64"}
>Server Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.1", GitCommit:"206bcadf021e76c27513500ca24182692aabd17e", GitTreeState:"clean", BuildDate:"2020-09-09T11:18:22Z", GoVersion:"go1.15", Compiler:"gc", Platform:"linux/amd64"}

`istioctl version`
>client version: 1.7.1
>control plane version: 1.7.1
>data plane version: 1.7.1 (11 proxies)

## Quick Setup
```
bash ./setup.sh
```
Run the above command to setup the entire cluster including all instalations below
and follow all the prompts.

## Load test the cluster
```
bash ./utils/nodejs-load.sh
bash ./utils/springboot-load.sh (in another terminal)
```
Make sure your cluster is completely booted up and all applications are ready before starting the load tests

#### Istio installation
```
curl -L https://istio.io/downloadIstio | sh -
mv istio-1.7.1 /usr/local/bin
echo "export PATH=${PATH}:/usr/local/bin/istio-1.7.1/bin" >> ~/.bash_profile
echo "export PATH=${PATH}:/usr/local/bin/istio-1.7.1/bin" >> ~/.zhrc
source ~/.bash_profile
source ~/.zhrc
istioctl version
```

#### Starting the cluster
```
minikube start --kubernetes-version=v1.19.1 --memory=6g --cpus 4 --driver=hyperkit --extra-config=kubelet.authentication-token-webhook=true --extra-config=kubelet.authorization-mode=Webhook
minikube addons enable metrics-server
minikube addons enable ingress
```

#### Configuring the cluster to inject sidecar proxies
```
k label namespace default istio-injection=enabled
kubectl get namespaces --show-labels
istioctl install
```

#### Install prometheus/kiali/grafana/jaeger
```
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/prometheus.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/kiali.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/grafana.yaml
kubectl apply -f /usr/local/bin/istio-1.7.1/samples/addons/jaeger.yaml
```

#### Install applications in the local cluster
```
cd k8s
helm install hello-springboot ./hello-kubernetes
helm install hello-nodejs ./hello-kubernetes
helm install ingress ./ingress
```

#### Running a NodeJS and Springboot app in kubernetes
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