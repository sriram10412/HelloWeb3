# Create a GKE cluster
module "gke" {
  source              = "terraform-google-modules/kubernetes-engine/google"
  cluster_name        = "my-gke-cluster"
  project_id          = "MY_FIRST_GCP"
  region              = "asia-southeast1-c"
  network             = module.vpc.network_name
  subnetwork          = module.vpc.subnetwork_name
  ip_range_pods       = module.vpc.pod_ip_range
  ip_range_services   = module.vpc.service_ip_range
  enable_basic_auth   = false
  enable_legacy_abac  = false
  enable_network_policy = false

  node_pools = {
    default = {
      machine_type = "n1-standard-2"
      min_count    = 1
      max_count    = 3
    }
  }
}
