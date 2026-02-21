# Prometheus Deployment

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_deployment" "prometheus" {
  metadata {
    name = "prometheus"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "prometheus"
      }
    }
    template {
      metadata {
        labels = {
          app = "prometheus"
        }
      }
      spec {
        container {
          name  = "prometheus"
          image = "prom/prometheus:latest"
          ports {
            container_port = 9090
          }
          volume_mount {
            name      = "config-volume"
            mount_path = "/etc/prometheus"
          }
        }
        volume {
          name = "config-volume"
          config_map {
            name = "prometheus-config"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "prometheus" {
  metadata {
    name = "prometheus"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  spec {
    selector = {
      app = "prometheus"
    }
    port {
      port = 9090
      target_port = 9090
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_config_map" "prometheus_config" {
  metadata {
    name = "prometheus-config"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  data = {
    "prometheus.yml" = <<-EOT
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['localhost:9090']
    EOT
  }
}