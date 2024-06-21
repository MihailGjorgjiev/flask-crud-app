function Check-PodStatus {

    $readyPods = kubectl get pods --namespace=flask-app-ns --field-selector=status.phase=Running --output=jsonpath='{.items[*].status.phase}'
    $numPods = $readyPods.Split(' ').Count
    $expectedNumPods = 4  # Replace with the expected number of pods

    if ($numPods -eq $expectedNumPods) {
        Write-Host "All pods are running."
        return 0  # Success
    }
    else {
        Write-Host "Waiting for all pods to be running..."
        return 1  # Continue waiting
    }
}



# Starting Minikube
# Write-Host "Starting Minikube..."
# minikube start

# Applying Kubernetes configuration
Write-Host "Applying Kubernetes configuration..."
kubectl apply -f ./kubernetes/namespace.yaml
kubectl apply -f ./kubernetes/secrets.yaml -n flask-app-ns
kubectl apply -f ./kubernetes/deployment.yaml -n flask-app-ns
kubectl apply -f ./kubernetes/service.yaml -n flask-app-ns
kubectl apply -f ./kubernetes/ingress.yaml -n flask-app-ns
kubectl apply -f ./kubernetes/statefulset.yaml -n flask-app-ns



while (-not (Check-PodStatus)) {
    Start-Sleep -Seconds 10 # Wait for 10 seconds before checking again
}

Write-Output "Deployment complete."

# kubectl port-forward service/flasespace-service 8080:80 -n flask-app-ns