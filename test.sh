#!/usr/bin/bash
set -ex

# Function to check if all pods are ready
check_pods_ready() {
    PODS_READY=$(kubectl get pods -l app=flask-app -o=jsonpath='{.items[*].status.containerStatuses[0].ready}' | tr ' ' '\n' | sort | uniq)
    if [ "$PODS_READY" != "true" ]; then
        echo "Not all pods are ready. Retrying in 5 seconds..."
        sleep 5
        check_pods_ready
    fi
}

# Wait for all pods to be ready
check_pods_ready

# Function to check if the LoadBalancer IP address is available
check_loadbalancer_ip() {
    CLUSTER_IP=$(kubectl get service flask-app-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
    if [ -z "$CLUSTER_IP" ]; then
        echo "LoadBalancer IP not found. Retrying in 5 seconds..."
        sleep 5
        check_loadbalancer_ip
    fi
}

# Wait for the LoadBalancer IP address
check_loadbalancer_ip

# Run your tests using the LoadBalancer IP
timeout 20 curl -s "http://$CLUSTER_IP:5000/"

echo "Test finished successfully"
