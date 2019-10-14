# verisioning, we will #reviseit later
# terraform {
#   required_version = ">= 0.12, < 0.13"
# }

provider "google" {
  # credentials = "${file("~/.config/gcloud/terraform@${var.project_id}.json")}"
  credentials = "${file("~/.config/gcloud/node-3tier-application-a3806f97e8d9.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

provider "google-beta" {
  # credentials = "${file("~/.config/gcloud/terraform@${var.project_id}.json")}"
  credentials = "${file("~/.config/gcloud/node-3tier-application-a3806f97e8d9.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

module "k8s" {
  source         = "../../../modules/services/k8s"
  project_id        = "${var.project_id}"
  region         = "${var.region}"
  zones           = "${var.zones}"
  instance_type  = "g1-small"
  min_node_count = 1
  max_node_count = 3
}


module "db" {
  source            = "../../../modules/cloudsql"
  region            = "${var.region}"
  sql_instance_size = "db-f1-micro"
  # zones           = "${var.zones}"
  # enable_replica = true
  # availibility_type = "REGIONAL"
}
