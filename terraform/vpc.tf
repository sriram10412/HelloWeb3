resource "google_compute_network" "my_first_vpc" {
  name                    = "my_first_vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my_first_subnet" {
  name                     = "my_first_subnet"
  ip_cidr_range            = "10.0.1.0/24"
  network                  = google_compute_network.my_first_vpc.self_link
  private_ip_google_access = true
  region                   = "asia-southeast1-c"

}

###Aditional configuration candidate might fined usefull to add
