resource "gitlab_project_variable" "ci_vars" {
  for_each  = var.gitlab_ci_vars
  project   = var.gitlab_project
  key       = each.key
  value     = each.value
  protected = false
}
