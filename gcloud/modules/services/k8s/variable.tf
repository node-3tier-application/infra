# commonly used variables declaration
variable "project_id" {}
variable "region" {}
variable "zones" {
  type = "list"
}

variable "instance_type" {
  default = "g1-small"
  description = "default instance type to use"
}
variable "initial_node_count" {
  default = 1
  description = "initial number of nodes on pool"
}

variable "min_node_count" {
  default = 1
  description = "minimum number of nodes on pool"
}
variable "max_node_count" {
  default = 3
  description = "maximum number of nodes on pool"
}

variable "primary_nodes_name" {
  description = "Name of primary node pool group"
  default = "primary-nodes"
}
