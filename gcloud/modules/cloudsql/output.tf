output "database_url" {
  value = "postgresql://${google_sql_user.master-user.name}:${google_sql_user.master-user.password}@${google_sql_database_instance.master.private_ip_address}/${google_sql_database.db-name.name}"
  # sensitive = true
}
