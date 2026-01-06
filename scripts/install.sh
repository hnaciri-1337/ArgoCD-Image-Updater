#!/bin/bash
set -e

echo "[1/8] Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y curl git ca-certificates gnupg lsb-release vim

echo "[2/8] Installing K3S..."
curl -sfL https://get.k3s.io | sh -

echo "[3/8] Waiting for K3s API server to be ready..."
until sudo /usr/local/bin/kubectl get nodes >/dev/null 2>&1; do
  sleep 2
done

echo "[4/8] Installing ArgoCD and ArgoCD Image Updater..."
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/config/install.yaml

echo "[5/8] Installing Helm 4 and creating dev namespace..."
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 | bash
sudo kubectl create namespace dev


echo "[6/8] Intalling Docker and configuring git..."
sudo curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

git config --global user.name "hnaciri-1337"

echo "[7/8] Exposing ArgoCD ports..."
./scripts/exposeArgoCD.sh

echo "[8/8] Retrieving ArgoCD initial admin password..."
./scripts/passwordArgoCD.sh
