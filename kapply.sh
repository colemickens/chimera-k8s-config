#!/usr/bin/env bash

set -x
set -e
set -u

./init-oauth2proxy-secret.sh
./init-twitlistauth-secret.sh

for f in *.yaml ; do
	kubectl apply -f $f
done

#kubectl delete pods --all