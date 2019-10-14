# commonly used variables declaration
variable region {}

variable "sql_instance_size" {
  default     = "db-f1-micro"
  description = "Size of Cloud SQL instances"
}

variable "enable_backup" {
  default     = false
  description = "If set true, backup is enabled"
}

variable "sql_master_zone" {
  default     = "b"
  description = "Zone of the Cloud SQL master (a, b, ...)"
}

variable "sql_replica_zone" {
  default     = "c"
  description = "Zone of the Cloud SQL replica (a, b, ...)"
}

variable "sql_db_version" {
  default     = "POSTGRES_9_6"
  description = "Postgresql  version to use"
}

variable "availability_type" {
  default     = "ZONAL"
  description = "Availability type for HA, high availability (REGIONAL) or single zone (ZONAL)"
}

variable "enable_replica" {
  description = "If true, replica is enabled"
  default     = false
}
