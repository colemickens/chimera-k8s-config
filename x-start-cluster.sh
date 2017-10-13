#!/bin/bash

set -x
set -e
set -u

yaourt -S {kubectl,kubelet,kubeadm,kubernetes-cni}-bin --needed --noconfirm

sudo systemctl daemon-reload

sudo systemctl start kubelet
sudo systemctl enable kubelet
sudo kubeadm init

mkdir -p $HOME/.kube                           
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config                                        
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f http://docs.projectcalico.org/v2.3/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl create clusterrolebinding permissive-binding \
  --clusterrole=cluster-admin \
  --user=admin \
  --user=kubelet \
  --group=system:serviceaccounts

helm init

