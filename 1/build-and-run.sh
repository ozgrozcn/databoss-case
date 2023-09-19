#! /bin/bash

source $(pwd)/.env

if [ "$EUID" -ne 0 ]
  then echo "Please run as root user"
  exit
  
  else
    docker image build -f ${DOCKERFILE_NAME} . --tag ${IMAGE_NAME}:${IMAGE_VERSION}
    if [ "$1" == "true" ]
    then docker-compose up -d 
    fi
fi

