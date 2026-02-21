# Grafana Deployment Configuration

provider "google" {
  credentials = file("/path/to/credentials.json")
  project     = var.project_id
  region      = var.region
}

resource "google_compute_instance" "grafana" {
  name         = "grafana-instance"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata_startup_script = <<-EOT
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:grafana/ppa
    sudo apt-get update
    sudo apt-get install -y grafana
    sudo systemctl enable grafana-server
    sudo systemctl start grafana-server
  EOT
}

output "grafana_url" {
  value = "http://${google_compute_instance.grafana.network_interface[0].access_config[0].nat_ip}:3000"
}

variable "project_id" {}
variable "region" {}
variable "zone" {}