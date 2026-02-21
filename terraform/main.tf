# Google Kubernetes Engine (GKE) Configuration

provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

resource "google_container_cluster" "primary" {
  name      = "primary-cluster"
  location  = "us-central1"

  master_auth {
    username = "admin"
    password = var.cluster_password
  }
  remove_default_node_pool = true
  initial_node_count       = 1

  node_pool {
    name = "default-pool"
    node_count = 1

    node_config {
      machine_type = "e2-medium"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }
}

# Variables
variable "cluster_password" {
  description = "Password for the GKE cluster"
  type        = string
}