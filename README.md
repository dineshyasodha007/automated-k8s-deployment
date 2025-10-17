# Automated Kubernetes Deployment - Hello Web App

## Overview
This project demonstrates the automated deployment of a simple "Hello, World" web application using modern DevOps principles:

- Infrastructure as Code (IaC) with **Terraform** to provision an **AWS EKS cluster**.
- **Containerization** using Docker (Nginx serving `index.html`).
- Kubernetes deployment using **YAML manifests** (Deployment + Service).
- **CI/CD pipeline** automation using **Jenkins**.

The goal is to provide a fully reproducible setup that allows  to deploy the application with minimal effort.

---

## Repository Structure
```

├── README.md
├── app/
│   ├── index.html
│   └── Dockerfile
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── providers.tf
└── jenkins/
└── Jenkinsfile

````

---

## How to Run ( Instructions)

### 1️⃣ Terraform (Provision EKS)
```bash
cd terraform
terraform init
terraform apply -auto-approve
````

This will create:

* A VPC with public subnets
* An AWS EKS cluster
* A managed node group

After creation, configure `kubectl`:

```bash
aws eks update-kubeconfig --name demo-eks-cluster --region us-east-1
kubectl get nodes
```

---

### 2️⃣ Docker & Kubernetes (Application Deployment)

1. Build Docker image:

```bash
cd app
docker build -t <dockerhub-username>/hello-nginx:latest .
docker push <dockerhub-username>/hello-nginx:latest
```

2. Deploy to Kubernetes:

```bash
kubectl apply -f ../k8s/deployment.yaml
kubectl apply -f ../k8s/service.yaml
kubectl get svc
```

* Service type is **LoadBalancer**, which will provide a public IP to access the app.

---

### 3️⃣ Jenkins Pipeline (CI/CD)

1. Create a **Jenkins Pipeline Job** pointing to this repository.
2. Add credentials:

   * Docker Hub credentials (`dockerhub-credentials`)
   * AWS IAM access (if using Jenkins to run `kubectl` commands)
3. Pipeline stages (defined in `jenkins/Jenkinsfile`):

   1. Checkout latest code
   2. Build Docker image from `app/Dockerfile`
   3. Push Docker image to Docker Hub
   4. Update Kubernetes Deployment manifest with new image
   5. Apply manifests to EKS cluster

This ensures that every push to the repository automatically triggers a new deployment.

---

## Design Choices

* **Terraform**: Pure Terraform resources, no Helm or external modules, for simplicity and clarity.
* **Docker**: Uses `nginx:alpine` for a small, efficient image.
* **Kubernetes**: Deployment configured with 2 replicas for basic scaling, LoadBalancer service for public access.
* **Jenkins**: Declarative pipeline for automated build, push, and deployment.

---

## Live Application

* Evaluators can follow the instructions above to deploy the application on AWS EKS.

---

## Notes

* All code is modular and structured for clarity.
* `.gitignore` excludes unnecessary files like Terraform state, IDE configs, and logs.
* Designed for **reproducibility**, allowing the evaluator to run the entire pipeline end-to-end.

```



