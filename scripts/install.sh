#!/bin/bash
set -e

echo "[1/6] Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y curl git ca-certificates gnupg lsb-release vim

echo "[2/6] Installing K3S..."
curl -sfL https://get.k3s.io | sh -

echo "[3/6] Waiting for K3s API server to be ready..."
until sudo /usr/local/bin/kubectl get nodes >/dev/null 2>&1; do
  sleep 2
done

echo "[4/6] Installing ArgoCD and ArgoCD Image Updater..."
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/config/install.yaml

sudo kubectl create namespace dev

git config --global user.name "hnaciri-1337"

echo "DONE ✅"

echo "[5/6] Exposing ArgoCD ports..."
./scripts/exposePorts.sh

echo "[6/6] Retrieving ArgoCD initial admin password..."
./scripts/passwordArgoCD.sh
