#!/usr/bin/env bash

set -x
set -e
set -u

helm install \
	--name kl \
	--set config.LEGO_EMAIL=cole.mickens@gmail.com \
	--set config.LEGO_URL=https://acme-v01.api.letsencrypt.org/directory \
	stable/kube-lego
