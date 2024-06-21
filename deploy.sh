#!/bin/bash
check_pod_status() {
    local ready_pods=$(kubectl get pods --namespace=flask-app-ns --field-selector=status.phase=Running --output=jsonpath='{.items[*].status.phase}')
    local num_pods=$(echo "$ready_pods" | wc -w)
    local expected_num_pods=4  # Replace with the expected number of pods

    if [ "$num_pods" -eq "$expected_num_pods" ]; then
        echo "All pods are running."
        return 0  # Success
    else
        echo "Waiting for all pods to be running..."
        return 1  # Continue waiting
    fi
}

echo "Starting Minikube..."
minikube start

echo "Applying Kubernetes configuration..."
kubectl apply -f ./kubernetes/namespace.yaml
kubectl apply -f  ./kubernetes/secrets.yaml -n flask-app-ns
kubectl apply -f  ./kubernetes/deployment.yaml -n flask-app-ns
kubectl apply -f  ./kubernetes/service.yaml -n flask-app-ns
kubectl apply -f  ./kubernetes/ingress.yaml -n flask-app-ns
kubectl apply -f  ./kubernetes/statefulset.yaml -n flask-app-ns


while ! check_pod_status; do
    sleep 10  # Wait for 5 seconds before checking again
done

echo "Deployment complete."

# kubectl port-forward service/flasespace-service 8080:80 -n flask-app-ns
