#!/bin/bash

# Navigate to the directory containing your Dockerfile
cd amd-gpu/Pip

# Build the Docker image
docker build -t dolphin-mistral-inference:v1 .

# Run the Docker image to ensure it's working
docker run -it --rm -P dolphin-mistral-inference:v1

# Start Minikube
minikube start

# Load the Docker image into Minikube
minikube image load dolphin-mistral-inference:v1

# Confirm that the image has been loaded into Minikube
minikube image list

# Create a Kubernetes deployment using kubectl
kubectl create deploy dolphin-mistral-inference-deployment --image=dolphin-mistral-inference:v1

# Check the list of deployments
kubectl get deploy

# Check the list of pods
kubectl get pod

# Expose the deployment as a service with specified ports
kubectl expose deploy/dolphin-mistral-inference-deployment --name=dm-inference-deployment --target-port=8888 --port=1234

# Access the service using Minikube
minikube service dm-inference-deployment
