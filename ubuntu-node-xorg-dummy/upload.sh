#!/bin/sh
export NAME=ulikoehler/ubuntu-node-xorg-dummy
export VERSION=16
docker build -t ${NAME}:${VERSION} .
docker push ${NAME}:${VERSION}
