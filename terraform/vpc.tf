resource "google_compute_network" "vpc" {
  name                    = "my_first_vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = true
}

###Aditional configuration candidate might fined usefull to add
