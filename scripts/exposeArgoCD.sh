#!/bin/bash
set -e
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0
