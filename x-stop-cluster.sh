#!/bin/bash

set -x

sudo systemctl stop kubelet
sudo systemctl disable kubelet

# kubeadm reset outputs this line:
#  [reset] Unmounting mounted directories in "/var/lib/kubelet"
# so I'm going to assume this is no longer needed:
#sudo systemctl stop docker
#sudo find /var/lib/kubelet | xargs -t -n 1 findmnt -n -t tmpfs -o TARGET -T | uniq | xargs -t -r sudo umount -v;
#sudo systemctl start docker

docker kill $(docker ps -aq); docker rm $(docker ps -aq)

sudo kubeadm reset

