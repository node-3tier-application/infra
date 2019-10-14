resource "random_id" "gke-cluster" {
  byte_length = 4
}

resource "google_container_cluster" "primary" {
  name           = "${var.project_id}-${random_id.gke-cluster.hex}"
  location       = "${var.region}"
  node_locations = "${var.zones}"

  remove_default_node_pool = true
  initial_node_count       = "${var.initial_node_count}"
  # depends_on = [
  #   "google_project_service.container"
  # ]

  ip_allocation_policy {
    use_ip_aliases = true
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name               = "${var.primary_nodes_name}"
  location           = "${google_container_cluster.primary.location}"
  cluster            = "${google_container_cluster.primary.name}"
  version            = "${google_container_cluster.primary.master_version}"
  initial_node_count = "${var.initial_node_count}"
  # node_count = 2
  autoscaling {
    min_node_count = "${var.min_node_count}"
    max_node_count = "${var.max_node_count}"
  }
  node_config {
    machine_type = "${var.instance_type}"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
