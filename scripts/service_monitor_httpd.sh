#!/bin/bash

# Define the name of the HTTP server service
SERVICE_NAME="httpd"

# Function to check if the service is running
check_service_status() {
    if systemctl is-active --quiet $SERVICE_NAME; then
        return 0  # Service is running
    else
        return 1  # Service is not running
    fi
}

# Function to start the service
start_service() {
    systemctl start $SERVICE_NAME
}

# Function to stop the service
stop_service() {
    systemctl stop $SERVICE_NAME
    echo "Stopping $SERVICE_NAME..."
}

# Main script logic
check_service_status

if [ $? -eq 0 ]; then
    echo "HTTPd is running."
else
    echo "HTTPd is not running. Attempting to start it..."
    start_service
    sleep 2  # Give the service a moment to start
    check_service_status

    if [ $? -eq 0 ]; then
        echo "HTTPd has been started successfully."
    else
        echo "Failed to start HTTPd."
    fi
fi
