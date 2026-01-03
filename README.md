# InceptionOfThings: GitOps Demo with ArgoCD, Kustomize, and Image Updater

## 🚀 Overview
This repository demonstrates a modern, automated GitOps workflow for Kubernetes using:
- **ArgoCD** for continuous delivery
- **Kustomize** for manifest management
- **ArgoCD Image Updater** for automatic container image updates

## 🗂️ Repository Structure
```
argo-config/
  argocd-app.yaml         # ArgoCD Application definition
  image-updater-app.yaml  # ArgoCD Image Updater configuration
confs/
  deployment.yaml         # Kubernetes Deployment
  service.yaml            # Kubernetes Service
  kustomization.yaml      # Kustomize overlay
scripts/
  install.sh              # Example install script for dependencies
  exposeApp.sh            # Script to expose the app service (e.g., via NodePort)
  exposeArgoCD.sh         # Script to expose ArgoCD UI/service
  passwordArgoCD.sh       # Script to retrieve ArgoCD admin password
Dockerfile                # Node.js app container build file
server.js                 # App entrypoint
```

## ⚙️ How It Works
- **ArgoCD** watches this repo and syncs changes to your Kubernetes cluster.
- **Kustomize** overlays allow flexible image/tag management.
- **ArgoCD Image Updater** automatically detects new image tags on Docker Hub and updates your deployment—no manual Git changes required.
- **Scripts** automate common tasks for local development and cluster management.

## 📝 Key Features
- Declarative Kubernetes manifests
- Automated deployment and image updates
- Helper scripts for setup, exposure, and password retrieval
- No secrets or credentials tracked in the repo
- GitOps best practices

## 🔄 Typical Workflow
1. Edit manifests in `confs/` and commit to GitHub
2. Build and push new image tags to Docker Hub (e.g., `hnaciri/iot:v1.0.1`)
3. ArgoCD Image Updater detects new tags and updates the deployment automatically
4. Use scripts in `scripts/` to help with local setup, exposing services, and retrieving credentials

## 🏁 Getting Started
1. Fork or clone this repo
2. Set up ArgoCD and ArgoCD Image Updater in your cluster
3. Point your ArgoCD Application to this repo
4. Build and push your app image to Docker Hub
5. Use the scripts in `scripts/` as needed for local or cluster management
6. Watch your deployment update automatically!

## 📂 Scripts Folder Explained
- `install.sh`: Installs required dependencies (e.g., kubectl, k3s, ArgoCD)
- `exposeApp.sh`: Exposes your app service, typically via NodePort or LoadBalancer
- `exposeArgoCD.sh`: Exposes the ArgoCD UI/service for web access
- `passwordArgoCD.sh`: Retrieves the initial ArgoCD admin password for login

These scripts are provided as examples and helpers. You can adapt them for your own environment or use them as templates for automation.

## 📚 Learn More
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/en/stable/)
- [Kustomize Documentation](https://kubectl.docs.kubernetes.io/references/kustomize/)
- [ArgoCD Image Updater](https://argocd-image-updater.readthedocs.io/en/stable/)

---

**Maintainer:** hnaciri-1337
