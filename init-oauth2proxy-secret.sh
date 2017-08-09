#!/usr/bin/env bash

set -x
set -e
set -u

kubectl delete secret oauth2proxy || true

kubectl create secret generic oauth2proxy \
    --from-file="oauth2proxy.config=./secrets/oauth2proxy.config"
