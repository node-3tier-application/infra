provider "gitlab" {
  token = "${var.gitlab_token}"
}

data "terraform_remote_state" "local_tfstate" {
  backend = "local"

  config = {
    path = "../../services/k8s/terraform.tfstate.d/production/terraform.tfstate"
  }
}

provider "kubernetes" {}

data "kubernetes_secret" "gitlab_token" {
  metadata {
    #TODO: #reviselater
    name      = "gitlab-admin-token-9srkh"
    namespace = "kube-system"
  }
}


variable "gitlab_projects" {
  type        = map(string)
  description = "list of gitlab project ids"
  default = {
    api = "14808338"
    web = "14808355"
  }
}



module "gitlab" {
  source = "../../../modules/gitlab"
  # FOR FUTURE VERSION 
  # for_each       = var.gitlab_projects
  # gitlab_project = tag.value
  
  # count          = length(var.gitlab_projects)
  # gitlab_project = var.gitlab_projects[count.index]
  gitlab_project = var.gitlab_projects["api"]
  gitlab_ci_vars = {
    SERVER                     = "https://${data.terraform_remote_state.local_tfstate.outputs.endpoint}"
    CERTIFICATE_AUTHORITY_DATA = data.terraform_remote_state.local_tfstate.outputs.cluster_ca_certificate
    USER_TOKEN                 = data.kubernetes_secret.gitlab_token.data.token
  }
}

module "gitlab_web" {
  source = "../../../modules/gitlab"
  gitlab_project = var.gitlab_projects["web"]
  gitlab_ci_vars = {
    SERVER                     = "https://${data.terraform_remote_state.local_tfstate.outputs.endpoint}"
    CERTIFICATE_AUTHORITY_DATA = data.terraform_remote_state.local_tfstate.outputs.cluster_ca_certificate
    USER_TOKEN                 = data.kubernetes_secret.gitlab_token.data.token
  }
}
