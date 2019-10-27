#!/bin/bash
if [[ ! -e "{$pod.yaml}" ]]; then # Check if the files already exists
    kubectl create -f pod.yaml
    kubectl get pods
else
    echo -n "ERROR:  pod.yaml doesn't exist on current path"
fi