#!/bin/bash

set -x

sudo systemctl stop kubelet
sudo systemctl disable kubelet
sudo find /var/lib/kubelet | xargs -n 1 findmnt -n -t tmpfs -o TARGET -T | uniq | xargs -r sudo umount -v;
docker kill $(docker ps -aq); docker rm $(docker ps -aq)
sudo kubeadm reset
