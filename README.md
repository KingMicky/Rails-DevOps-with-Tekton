# Ruby on Rails DevOps Project 🚀

This project demonstrates deploying a simple Ruby on Rails application with PostgreSQL using **Docker**, **Kubernetes**, **ArgoCD**, and **Tekton Pipelines**. It follows GitOps and CI/CD best practices.

---

## 📦 Local Development & Testing

### 🐳 Step 1: Run Locally with Docker Compose

#### 📁 Requirements
- Docker
- Docker Compose

#### ▶️ Commands
```bash
cd backend
docker-compose up --build
```

#### 🔗 Access the App
Open [http://localhost:3000](http://localhost:3000)

---

## ☸️ Step 2: Deploy to Kubernetes Locally (Minikube)

#### 📁 Requirements
- [Minikube](https://minikube.sigs.k8s.io/)
- kubectl

#### ▶️ Start Minikube
```bash
minikube start
minikube addons enable ingress
```

#### 🛠️ Apply Manifests
```bash
kubectl apply -f k8s/postgres-statefulset.yaml
kubectl apply -f k8s/rails-deployment.yaml
kubectl apply -f k8s/ingress.yaml
```

#### 🔗 Update /etc/hosts
```bash
echo "$(minikube ip) rails.local" | sudo tee -a /etc/hosts
```

#### 🌐 Access the App
Open [http://rails.local](http://rails.local)

---

## 🚀 Step 3: ArgoCD Setup (GitOps)

#### 📁 Requirements
- ArgoCD installed in your cluster

#### ▶️ Install ArgoCD
```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### 🔐 Login to ArgoCD UI
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Then go to: [https://localhost:8080](https://localhost:8080)

Default login:
- Username: `admin`
- Password: (get with command below)

```bash
kubectl -n argocd get secret argocd-initial-admin-secret   -o jsonpath="{.data.password}" | base64 -d
```

#### 🔁 Deploy via GitOps
```bash
kubectl apply -f argo-apps/
```

ArgoCD will automatically sync and deploy the app from the GitHub repository.

---

## 🔁 Step 4: CI/CD with Tekton Pipelines

#### 📁 Requirements
- Tekton Pipelines + Dashboard installed

#### ▶️ Install Tekton
```bash
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
```

#### 🖥️ Open Tekton Dashboard
```bash
kubectl port-forward svc/tekton-dashboard -n tekton-pipelines 9097:9097
```

Go to: [http://localhost:9097](http://localhost:9097)

#### ⚙️ Apply Pipeline Files
```bash
kubectl apply -f tekton/pipeline.yaml
kubectl apply -f tekton/pipeline-run.yaml
```

Tekton will:
- Clone the repo
- Build Docker image using Kaniko
- Push to Docker Hub

---

## 📁 Project Structure

```
my-app/
├── rails-app/                  # Rails app & Dockerfile
├── k8s/                      # Kubernetes manifests
├── argo-apps/                # ArgoCD GitOps configs
├── tekton/                   # Tekton pipeline files
├── docker-compose.yml        # Local Docker Compose
└── README.md
```

---

## 🔗 Useful Links

- [ArgoCD Documentation](https://argo-cd.readthedocs.io/en/stable/)
- [Tekton Pipelines](https://tekton.dev/docs/)
- [Ingress NGINX Guide](https://kubernetes.github.io/ingress-nginx/deploy/)

---

## ✍️ Author

- **Your Name**
- [GitHub](https://github.com/KingMicky)

---

## 📝 License

This project is licensed under the MIT License.