#! /bin/bash
source /vagrant/.env

sudo mkdir -m 755 /etc/apt/keyrings && sudo apt-get update 
sudo apt-get install -y apt-transport-https ca-certificates curl containerd docker.io
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg 
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list 
sudo apt-get update 
sudo apt-get install -y kubelet kubeadm kubectl 
sudo apt-mark hold kubelet kubeadm kubectl 
sudo modprobe bridge && sudo modprobe br_netfilter 
sudo sysctl -w net.bridge.bridge-nf-call-iptables=1 
sudo sysctl -w net.ipv4.ip_forward=1 
sudo sysctl -p 

kubeadm join 192.168.56.13:6443 --token rhfwot.1kyhq5c6lddnnm4s \
	--discovery-token-ca-cert-hash sha256:95c497dca447747d19f24d747bdbcac02fc78217d0321059d58dd4060f57444d 
mkdir -p /home/vagrant/.kube && sudo mv /etc/kubernetes/kubelet.conf /home/vagrant/.kube/config
