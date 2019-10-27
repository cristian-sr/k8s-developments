#!/bin/bash

if [[ ! -e "$Dockerfile", "${index.js}" ]]; then # Check if the files already exists
    docker build . -t node-welcome-app
    docker run -d -p 3000 node-welcome
    docker ps
else
    echo -n "ERROR: Dockerfile or index.js on current path"
fi