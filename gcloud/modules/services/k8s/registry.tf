resource "google_project_service" "containerregistry" {
  service            = "containerregistry.googleapis.com"
  disable_on_destroy = false
}

data "google_container_registry_repository" "phony" {}

output "container_registry_url" {
  value = "${data.google_container_registry_repository.phony.repository_url}"
}
