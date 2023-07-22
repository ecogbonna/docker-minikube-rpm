#!/bin/bash

echo ">>> INSTALL DOCKER CE"

sudo dnf install -y dnf-utils zip unzip
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

sudo dnf remove -y runc
sudo dnf install -y docker-ce --nobest



echo ">>> FINISH DOCKER SETUP"

sudo systemctl enable docker.service
sudo systemctl start docker.service

sudo docker version



echo ">>> INSTALLING MINIKUBE"

sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/



echo ">>> STARTING A KUBERNETES CLUSTER WITH MINIKUBE"

sudo usermod -aG docker vagrant && newgrp docker
su - vagrant -c "/usr/local/bin/minikube start"



echo ">>> INSTALLING THE KUBERNETES CLIENT (KUBECTL)"

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
&& chmod +x kubectl && sudo mv kubectl /usr/local/bin/



echo ">>> CHECKING TO SEE THE CLUSTER IS UP AND KUBECTL CAN TALK TO IT"

su - vagrant -c "/usr/local/bin/kubectl cluster-info"


echo ">>> PREPARE ENVIRONMENT"

echo "alias docker=\"sudo /usr/bin/docker\"" >> /home/vagrant/.bash_profile
echo "alias k=kubectl" >> /home/vagrant/.bash_profile
echo "source <(kubectl completion bash)" >> /home/vagrant/.bash_profile
echo "source <(kubectl completion bash | sed s/kubectl/k/g)" >> /home/vagrant/.bash_profile





