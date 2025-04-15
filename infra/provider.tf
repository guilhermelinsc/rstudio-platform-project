terraform {
  backend "gcs" {
    bucket = "tf_glcs_backend"
    prefix = "k8s_rstudio"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.17"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-east1"
  zone    = "us-east1-b"
}

provider "kubernetes" {
  # host                   = "https://${module.gke.endpoint}"
  # token                  = data.google_client_config.default.access_token
  # cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  config_path = "~/.kube/config"
}