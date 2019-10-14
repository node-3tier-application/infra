resource "random_string" "database_password" {
  length  = 16
  special = false
}

resource "google_sql_user" "master-user" {
  name     = "user"
  instance = "${google_sql_database_instance.master.name}"
  password = "${random_string.database_password.result}"
}

resource "google_sql_database" "db-name" {
  name     = "database_name"
  instance = "${google_sql_database_instance.master.name}"
}
