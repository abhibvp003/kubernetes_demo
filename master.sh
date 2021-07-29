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

sudo kubeadm init --node-name kmaster01 
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"


# sudo apt install etcd-client
# sudo apt install nfs-kernel-server
# sudo apt install nodejs
# sudo apt install npm

# curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
# sudo apt-get install apt-transport-https --yes
# echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
# sudo apt-get update
# sudo apt-get -y install helm

# helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo add elastic https://helm.elastic.co
# helm repo add hashicorp https://helm.releases.hashicorp.com
# helm repo add jetstack https://charts.jetstack.io

# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml

# sudo apt update
# sudo apt install -y haproxy

# sudo apt -y install jq


# #install kes 
# wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
# rm -rf /usr/local/go
# sudo tar -C /usr/local -xzf go1.16.2.linux-amd64.tar.gz

# git clone https://github.com/minio/kes.git
# cd kes 
# GO111MODULE=on go get github.com/minio/kes/cmd/kes
