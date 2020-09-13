# Prerequisites
- minikube
- helm
- kubectl

# Starting the cluster
```
minikube start --memory 4096 --cpus 4 --driver=hyperkit
```

# Install both applications in local cluster
```
cd k8s
helm install hello-springboot ./hello-kubernetes
helm install hello-nodejs ./hello-kubernetes
```

# Running a NodeJS and Springboot app in kubernetes
`minikube ip`
>192.168.64.6

```
curl 192.168.64.6:30080/hello
curl 192.168.64.6:30081/hello
curl 192.168.64.6:30081/helloNode
```