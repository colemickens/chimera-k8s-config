#!/usr/bin/env bash

set -x
set -e
set -u

helm install \
  --name ng \
  --set controller.image.tag="0.9.0-beta.7" \
  --set controller.service.type=NodePort \
  --set controller.service.clusterIP=10.100.0.1 \
  --set=controller.service.nodePorts.http=30080 \
  --set=controller.service.nodePorts.https=30443 \
  --namespace=ingress \
  stable/nginx-ingress
