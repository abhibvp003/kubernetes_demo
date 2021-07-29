#! /bin/sh
	
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
 
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io



cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# sudo apt -y install nfs-common

# sudo mkdir -p /var/log/vault/audit
# sudo mkdir  /var/log/backend
# execute below command on master node and copy output and execute on worker with sudo
# ubuntu@ip-172-31-11-81:~$ kubeadm token create --print-join-command
# kubeadm join 172.31.11.81:6443 --token 0u7jcn.ubv49qy8r9cvrtpq     --discovery-token-ca-cert-hash sha256:284c7c08fde8956acad1fa30a31af4996bbc59deeb8b1a8ac241681fa3fc7cc9

# example
# on worker1 execute
# sudo kubeadm join 172.31.71.28:6443 --token c0drjt.b94sv7wrp8m07pi6     --discovery-token-ca-cert-hash sha256:5230c8e86253f535401bb10f5f0d36b72e79839ddd8d5ae2eca98ecf63f98528 --node-name kworker01
# on worker2 execute
# sudo kubeadm join 172.31.71.28:6443 --token c0drjt.b94sv7wrp8m07pi6     --discovery-token-ca-cert-hash sha256:5230c8e86253f535401bb10f5f0d36b72e79839ddd8d5ae2eca98ecf63f98528 --node-name kworker02

# kubeadm join 172.31.71.28:6443 --token q64txo.7hvvzveijxmvbjbz     --discovery-token-ca-cert-hash sha256:5230c8e86253f535401bb10f5f0d36b72e79839ddd8d5ae2eca98ecf63f98528 --node-name kworker03