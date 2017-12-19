#!/bin/bash

set -x
set -e
set -u

yaourt -S {kubectl,kubelet,kubeadm,kubernetes-cni}-bin --needed --noconfirm

sudo systemctl daemon-reload

sudo systemctl start kubelet
sudo systemctl enable kubelet
sudo kubeadm init --pod-network-cidr=10.0.0.0/16

mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
wget https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml -O /tmp/calico.yaml
sed -i 's|192.168.0.0/16|10.0.0.0/16|g' /tmp/calico.yaml
kubectl apply -f /tmp/calico.yaml

kubectl taint nodes --all node-role.kubernetes.io/master-

# TODO: This is lazy/tacky:
kubectl create clusterrolebinding permissive-binding \
  --clusterrole=cluster-admin \
  --user=admin \
  --user=kubelet \
  --group=system:serviceaccounts

helm init

