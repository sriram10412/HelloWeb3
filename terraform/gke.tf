# Google Kubernetes Engine (GKE) Cluster Configuration

provider "google" {
  project = "<YOUR_PROJECT_ID>"
  region  = "<YOUR_REGION>"
}

resource "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = "<YOUR_ZONE>"

  initial_node_count = 1

  node_config {
    machine_type = "n1-standard-1"
  }
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}