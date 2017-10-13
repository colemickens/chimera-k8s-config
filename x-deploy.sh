#!/bin/bash

set -x
set -e
set -u

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/alternative/kubernetes-dashboard-head.yaml

for f in *.yaml ; do
	kubectl apply -f $f
done

./init-nginx-ingress-helmchart.sh || true
./init-kube-lego-helmchart.sh || true
./init-oauth2proxy-secret.sh
./init-twitlistauth-secret.sh

