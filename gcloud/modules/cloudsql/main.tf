resource "random_id" "db-instance" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name             = "master-instance-${random_id.db-instance.hex}"
  database_version = "${var.sql_db_version}"
  region           = "${var.region}"
  depends_on = [
    "google_project_service.sqladmin",
    "google_service_networking_connection.private_vpc_connection"
  ]
  settings {
    tier              = "${var.sql_instance_size}"
    availability_type = "${var.availability_type}"
    ip_configuration {
      ipv4_enabled    = false
      private_network = "${google_compute_network.private_network.self_link}"
    }
    backup_configuration {
      enabled    = "${var.enable_backup}"
      start_time = "00:00"
    }
    location_preference {
      zone = "${var.region}-${var.sql_master_zone}"
    }
  }
  timeouts {
    create = "20m"
    update = "30m"
  }
}

resource "google_sql_database_instance" "replica" {
  count                = var.enable_replica ? 1 : 0
  name                 = "replica-instance-${terraform.workspace}"
  region               = var.region
  database_version     = var.sql_db_version
  master_instance_name = google_sql_database_instance.master.name

  settings {
    tier            = var.sql_instance_size
    disk_autoresize = true
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.private_network.self_link
    }
    location_preference {
      zone = "${var.region}-${var.sql_replica_zone}"
    }
  }
  depends_on = [
    "google_sql_database_instance.master",
    "google_service_networking_connection.private_vpc_connection"
  ]
}
