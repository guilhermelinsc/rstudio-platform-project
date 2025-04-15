# 📊 RStudio Platform Project

This repository presents a platform engineering project focused on deploying a containerized **RStudio Server** within a **Google Kubernetes Engine (GKE) Autopilot cluster**. It emphasizes reproducibility, automation, and modern CI/CD practices, serving as a foundation for scalable data science workflows in cloud environments.

---

## 🚀 Project Highlights

- **Cloud Infrastructure**: Deployment on Google Cloud's GKE Autopilot for managed Kubernetes services.
- **Containerization**: Custom Docker image for RStudio Server, facilitating consistent environments.
- **Infrastructure as Code**: Terraform scripts for provisioning cloud resources.
- **CI/CD Pipeline**: GitHub Actions workflows that:
  - Validate pull requests with deployment tests and security scans.
  - Build and push Docker images with semantic versioning.
  - Deploy updates to GKE upon successful validations.
- **Security**: Integration of Trivy for container image vulnerability scanning.

---

## 🍬 The Role of R and Rscript in Cancer Research

R is a powerful statistical programming language extensively used in biomedical research, particularly in oncology. Its scripting interface, `Rscript`, enables automation and reproducibility in data analysis workflows. Key applications include:

- **Genomic Data Analysis**: Utilizing packages like Bioconductor for analyzing DNA, RNA, and protein sequences to identify mutations and gene expression patterns.
- **Statistical Modeling**: Implementing survival analysis, logistic regression, and clustering algorithms to study patient outcomes and tumor classifications.
- **Machine Learning**: Employing tools such as `caret`, `randomForest`, and `xgboost` to build predictive models for cancer diagnosis and treatment response.
- **Data Visualization**: Creating publication-quality plots with `ggplot2` and developing interactive dashboards using `shiny`.

These capabilities make R an indispensable tool in cancer research, facilitating insights that drive advancements in diagnosis and therapy.

---

## 📁 Repository Structure

```bash
.
├── .github/workflows/    # GitHub Actions workflows for CI/CD
├── deploy/               # Kubernetes deployment manifests
├── docker/               # Dockerfile and related configurations
├── infra/                # Terraform scripts for infrastructure provisioning
├── .gitignore
├── LICENSE
├── VERSION
└── README.md
```

---

## 🔧 Getting Started

### Prerequisites

Make sure you have the following tools installed:

- [Docker](https://www.docker.com/)
- [Terraform](https://www.terraform.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Google Cloud SDK](https://cloud.google.com/sdk)

### 1. Provision Infrastructure

Provision the GKE Autopilot cluster using Terraform:

```bash
cd infra
terraform init
terraform apply
```

### 2. Build and Push the Docker Image

Build and push your custom RStudio Server image:

```bash
cd docker
docker build -t guilhermelinsc/rstudio-ms:<version> .
docker push guilhermelinsc/rstudio-ms:<version>
```

> Replace `<version>` with the desired semantic version tag.

### 3. Deploy to GKE

Apply the Kubernetes manifests:

```bash
kubectl apply -f deploy/deployment.yml
```

You can access RStudio by retrieving the external LoadBalancer IP:

```bash
kubectl get svc -n rstudio
```

---

## 🤝 Contributing

Contributions are welcome and encouraged! If you'd like to enhance this project, here are a few ideas to get started:

- 🔧 Add Terraform modules to support other cloud providers (e.g., AWS, Azure)
- 🧪 Expand the CI/CD pipeline with additional testing or policy enforcement
- 📦 Optimize the Docker image or support multi-arch builds
- ☘️ Introduce Helm charts or Kustomize support for more flexible deployments
- 📊 Add example R scripts or notebooks showcasing cancer research use cases

Feel free to fork the repo, create a feature branch, and open a pull request.  
Please follow best practices in your contributions and include meaningful documentation or comments when applicable.

Let’s build something impactful together!

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
