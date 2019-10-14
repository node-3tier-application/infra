variable "gitlab_project" {}
variable "gitlab_ci_vars" {
  description = "variables ci variables"
  type        = map(string)
}

# variable "hero_thousand_faces" {
#   description = "map"
#   type        = map(string)
#   default     = {
#     neo      = "hero"
#     trinity  = "love interest"
#     morpheus = "mentor"
#   }
# }
