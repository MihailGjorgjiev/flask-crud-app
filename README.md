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

2. Deploy the project using Shell:

- **Shell**: Run `deploy.sh`.
  ```
  ./deploy.sh
  ```

3. Wait until all pods are running

4. Go to 127.0.0.1:8080/books