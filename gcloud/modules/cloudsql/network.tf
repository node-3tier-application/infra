# private networking definition
resource "google_compute_network" "vpc_default" {
  provider = "google-beta"
  name       = "default"
  lifecycle{
    ignore_changes = ["description"]
    prevent_destroy = true
  }
}

resource "google_compute_global_address" "private_ip_address" {
  provider = "google-beta"

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "${google_compute_network.vpc_default.self_link}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = "google-beta"

  network                 = "${google_compute_network.vpc_default.self_link}"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_address.name}"]
  depends_on = [
    "google_project_service.servicenetworking"
  ]
}
