#!/usr/bin/env bash

set -x
set -u
set -e

RELEASE="ng"

W="./__nginx-tmpl-config.yaml"

if [[ ! -f "${W}" ]]; then
  curl "https://raw.githubusercontent.com/kubernetes/ingress/nginx-0.9.0-beta.7/controllers/nginx/rootfs/etc/nginx/template/nginx.tmpl" > "$W"
  sed -i 's/X-Original-URI/X-Auth-Request-Redirect/g' "${W}"
fi

kubectl delete configmap --namespace ingress nginx-template || true
kubectl create configmap --namespace ingress nginx-template --from-file=nginx.tmpl="${W}"

echo "this is manual for now..."

echo "--"
cat <<EOF
        volumeMounts:
          - mountPath: /etc/nginx/template
            name: nginx-template-volume
            readOnly: true
      volumes:
        - name: nginx-template-volume
          configMap:
            name: nginx-template
            items:
            - key: nginx.tmpl
              path: nginx.tmpl
EOF
echo "--"

read -n 1 c
kubectl edit deployment -o yaml -n ingress "${RELEASE}-nginx-ingress-controller"