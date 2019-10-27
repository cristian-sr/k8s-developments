#!/bin/bash
eval $(minikube docker-env)

docker build . -t my-first-image:1.0.0
