#! /bin/bash
apt install rubygems -y
gem install dotenv 

source $(pwd)/.env
vagrant up 

vagrant ssh $MASTER_NODE_NAME  -c "sudo mkdir -m 755 /etc/apt/keyrings && sudo apt-get update \
&& sudo apt-get install -y apt-transport-https ca-certificates curl containerd docker.io \
&& curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
&& echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list \
&& sudo apt-get update \
&& sudo apt-get install -y kubelet kubeadm kubectl \
&& sudo apt-mark hold kubelet kubeadm kubectl \
&& sudo modprobe bridge && sudo modprobe br_netfilter \
&& sudo sysctl -w net.bridge.bridge-nf-call-iptables=1 \
&& sudo sysctl -w net.ipv4.ip_forward=1 \
&& sudo sysctl -p \
&& sudo kubeadm init --apiserver-advertise-address=$MASTER_IP --pod-network-cidr=$NETWORK_CIDR | tail -n 2 | tee -a /vagrant/worker.sh \
&& echo 'mkdir -p $HOME/.kube && sudo mv /etc/kubernetes/kubelet.conf $HOME/.kube/config' >> /vagrant/worker.sh \
&& mkdir -p $HOME/.kube && sudo mv /etc/kubernetes/admin.conf $HOME/.kube/config"


vagrant ssh $WORKER_NODE_NAME1 -c "sudo bash /vagrant/worker.sh"
vagrant ssh $WORKER_NODE_NAME2 -c "sudo bash /vagrant/worker.sh"







