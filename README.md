# Transformers Models-k8s Deployment scripts 

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)

## About <a name = "about"></a>

Mainly to host model inference locally via the pipeline api
Multiple pod support has been added to the script

(Multithreading will be added soon)


## Getting Started <a name = "getting_started"></a>

Most of these are gonna be for deployment on k8s

Build whatever docker image you need

Example -> 

Since I use an amd gpu, that model is what we will be deploying


```
cd amd-gpu/Pip

# Building the dockerfile
docker build -t dolphin-mistral-inference:v1 . 

# Run the docker image once to make sure everything is working
docker run -it --rm -P dolphin-mistral-inference:v1

# Using minikube for the deployment (kubectl)
minikube start

minikube image load dolphin-mistral-inference:v1

# Confirm that the image has been loaded
minikube image list

kubectl create deploy dolphin-mistral-inference-deployment --image:dolphin-mistral-inference:v1

# Check the list of deployments
kubectl get deploy

kubectl get pod

kubectl expose deploy/dolphin-mistral-inference-deployment --name:dm-inference-deployment --target-port:8888 --port:1234

minikube service dm-inference-deployment
```


## Sample Request

`curl -X POST "http:localhost:8888/forward" -H "accept:application/json" -H "Content-Type:application/json" -d '{"inputs":"Tell me any 4 shades of blue"}' `

**Pipe into `jq` to view json properly**
