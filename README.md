# Running a NodeJS and Springboot app in kubernetes
```
cd app
docker pull innoirvingdev/hello-springboot:3.0

// modify deployments.yaml to point to that new image

cd k8s
helm install hello-springboot ./hello-kubernetes
helm install hello-nodejs ./hello-kubernetes
```
