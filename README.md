# Running a NodeJS app in the local minikube cluster
```
cd app
docker pull innoirvingdev/hello-springboot:3.0

// modify deployments.yaml to point to that new image

kubectl apply -f services.yaml
kubectl apply -f deployments.yaml
```