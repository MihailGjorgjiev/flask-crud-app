# Flask Book Application with Docker, Github Actions and Kubernetes

## Prerequisites
Before running this project, ensure you have the following tools installed:

- Docker
- Minikube
- kubectl

## Setup Instructions

1. Start Minikube by running the following command:
```
minikube start
```

2. Deploy the project using either shell or PowerShell:

- **Shell**: Run `deploy.sh`.
  ```
  ./deploy.sh
  ```

- **PowerShell**: Run `deploy.ps1`.
  ```
  ./deploy.ps1
  ```

3. Finally, for port forwarding in Kubernetes, use the following command:
```
kubectl port-forward service/flasespace-service 8080:80 -n flask-app-ns
```

