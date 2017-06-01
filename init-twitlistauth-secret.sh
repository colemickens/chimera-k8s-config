#!/usr/bin/env bash

set -x
set -e
set -u

kubectl delete secret twilistauth || true

kubectl create secret generic twilistauth \
    --from-file="twitlistauth.config=./secrets/twitlistauth.config"