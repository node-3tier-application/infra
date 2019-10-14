output "project_id" {
  value = module.k8s.project_id
}

output "cluster_name" {
  value = module.k8s.cluster_name
}

output "endpoint" {
  value = module.k8s.cluster_endpoint
}
output "cluster_ca_certificate" {
  value = module.k8s.cluster_ca_certificate
}

output "region" {
  value = module.k8s.region
}

output "database_url" {
  value = module.db.database_url
}
