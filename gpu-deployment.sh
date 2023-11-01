#!/bin/bash

# Function to display usage instructions
usage() {
  echo "Usage: $0 [test-run] [scale-replicas]"
  echo "If 'test-run' is provided, the script will run the Docker image for testing."
  echo "If 'scale-replicas' is provided, the script will scale the deployment to the specified number of replicas at the end."
  exit 1
}

# Check if 'test-run' argument is provided
if [ "$1" == "test-run" ]; then
  run_docker=true
  echo "Testing the Docker image will be executed after build."
else
  run_docker=false
  echo "Testing the Docker image will be skipped."
fi

# Navigate to the directory containing your Dockerfile
cd gpu/Pip

# Build the Docker image
echo "Building the Docker image..."
docker build -t dolphin-mistral-inference:v1 .
echo "Docker image built successfully."

# Run the Docker image for testing if requested
if [ "$run_docker" = true ]; then
  echo "Running the Docker image for testing..."
  docker run -it --rm -P dolphin-mistral-inference:v1
  echo "Docker image test complete."
fi

# Start Minikube
echo "Starting Minikube..."
minikube start
echo "Minikube started successfully."

# Load the Docker image into Minikube
echo "Loading the Docker image into Minikube..."
minikube image load dolphin-mistral-inference:v1
echo "Docker image loaded into Minikube."

# Confirm that the image has been loaded into Minikube
echo "List of images loaded in Minikube:"
minikube image list

# Create a Kubernetes deployment using kubectl
echo "Creating a Kubernetes deployment..."
kubectl create deploy dolphin-mistral-inference-deployment --image=dolphin-mistral-inference:v1
echo "Kubernetes deployment created."

# Check the list of deployments
echo "List of Kubernetes deployments:"
kubectl get deploy

# Check the list of pods
echo "List of pods in the deployment:"
kubectl get pod

# Expose the deployment as a service with specified ports
echo "Exposing the deployment as a service..."
kubectl expose deploy/dolphin-mistral-inference-deployment --name=dm-inference-deployment --target-port=8888 --port=1234
echo "Deployment exposed as a service."

# Access the service using Minikube
echo "Accessing the service using Minikube..."
minikube service dm-inference-deployment

# Check if 'scale-replicas' argument is provided
if [ -n "$2" ]; then
  # Scale the deployment to the specified number of replicas
  echo "Scaling the deployment to $2 replicas..."
  kubectl scale deploy/dolphin-mistral-inference-deployment --replicas="$2"
  echo "Deployment scaled to $2 replicas."
fi
