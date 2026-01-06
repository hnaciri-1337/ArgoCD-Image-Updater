
# InceptionOfThings: GitOps with ArgoCD, OCI Registry, and Image Updater

## 🚀 Overview

This repository demonstrates a modern, automated GitOps workflow for Kubernetes using:
- **ArgoCD** for continuous delivery
- **Helm** for manifest management and packaging
- **OCI Registry** (DockerHub) for storing and distributing Helm charts
- **ArgoCD Image Updater** for automatic container image updates, with changes committed to a separate branch


## 🗂️ Repository Structure
```
argo-config/
  argocd-app-oci.yaml      # ArgoCD Application definition (using OCI registry)
  dockerhub.oci.yaml       # DockerHub OCI registry secret for ArgoCD
  image-updater-app.yaml   # ArgoCD Image Updater configuration
argocd-confs/
  Chart.yaml               # Helm chart definition
  values.yaml              # Helm values (image, tag, etc.)
  templates/
    deployment.yaml        # Kubernetes Deployment (Helm template)
    service.yaml           # Kubernetes Service (Helm template)
scripts/
  install.sh               # Install dependencies, K3s, ArgoCD, Helm, Docker
  exposeApp.sh             # Expose the app service (port-forward)
  exposeArgoCD.sh          # Expose ArgoCD UI (port-forward)
  passwordArgoCD.sh        # Retrieve ArgoCD admin password
```


## ⚙️ How It Works
- **ArgoCD** syncs your Kubernetes cluster with Helm charts stored in an OCI registry (DockerHub), not a GitHub repo.
- **Helm** is used for packaging and templating Kubernetes manifests.
- **ArgoCD Image Updater** detects new image tags and directly updates the ArgoCD Application resource (using the "argocd" write-back method, not by committing to a Git branch).
- **Scripts** automate installation, exposure, and credential retrieval tasks.


## 📝 Key Features
- Declarative Kubernetes manifests via Helm
- Automated deployment and image updates using OCI registry
- Image updater commits changes to a dedicated branch (not main)
- Helper scripts for setup, exposure, and password retrieval
- No secrets or credentials tracked in the repo (except for demo secret in argo-config/dockerhub.oci.yaml)
- GitOps best practices


## 🔄 Typical Workflow (OCI & Image Updater)
1. **Run the install script:**
  ```bash
  ./scripts/install.sh
  ```
  This sets up K3s, ArgoCD, ArgoCD Image Updater, Helm, Docker, and exposes required ports.

2. **Package your Helm chart:**
  ```bash
  helm package argocd-confs
  ```

3. **Push the Helm chart to the OCI registry (DockerHub):**
  ```bash
  helm push argocd-confs-<version>.tgz oci://registry-1.docker.io/hnaciri/conf
  ```


4. **Apply the DockerHub OCI secret:**
  ```bash
  kubectl apply -f argo-config/dockerhub.oci.yaml
  ```
  This allows ArgoCD to authenticate and pull Helm charts from the OCI registry.

5. **Deploy the ArgoCD Application:**
  ```bash
  kubectl apply -f argo-config/argocd-app-oci.yaml
  ```

6. **Apply the ArgoCD Image Updater application:**
  ```bash
  kubectl apply -f argo-config/image-updater-app.yaml
  ```
  This deploys the ArgoCD Image Updater in your cluster.

7. **Image update workflow:**
   - When a new image is pushed to DockerHub, ArgoCD Image Updater detects it.
   - The updater directly updates the image tag in the ArgoCD Application resource (using the "argocd" write-back method).
   - No Git branch or commit is created; the update is applied live in the cluster.

8. **Expose services and retrieve credentials:**
  - Use `scripts/exposeApp.sh` to port-forward the app.
  - Use `scripts/exposeArgoCD.sh` to port-forward the ArgoCD UI.
  - Use `scripts/passwordArgoCD.sh` to get the ArgoCD admin password.

## 🏁 Getting Started
1. Fork or clone this repo
2. Set up ArgoCD and ArgoCD Image Updater in your cluster
3. Point your ArgoCD Application to this repo
4. Build and push your app image to Docker Hub
5. Use the scripts in `scripts/` as needed for local or cluster management
6. Watch your deployment update automatically!


## 📂 Scripts Folder Explained
- `install.sh`: Installs dependencies, K3s, ArgoCD, ArgoCD Image Updater, Helm, Docker, and exposes ports
- `exposeApp.sh`: Port-forwards the app service (default: 1337)
- `exposeArgoCD.sh`: Port-forwards the ArgoCD UI (default: 8080)
- `passwordArgoCD.sh`: Retrieves the initial ArgoCD admin password for login

These scripts are provided as helpers and can be adapted for your environment.


## 📚 Learn More
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/en/stable/)
- [Helm OCI Support](https://helm.sh/docs/topics/registries/)
- [ArgoCD Image Updater](https://argocd-image-updater.readthedocs.io/en/stable/)

---


**Maintainer:** hnaciri-1337
