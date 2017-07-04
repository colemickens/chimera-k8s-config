#!/bin/bash

set -x

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard-head.yaml
./init-nginx-ingress-helmchart.sh
./init-kube-lego-helmchart.sh
./init-oauth2proxy-secret.sh
./init-twitlistauth-secret.sh
./kapply.sh
