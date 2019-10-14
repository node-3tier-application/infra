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
    name = "gitlab-admin-token-9srkh" 
    namespace = "kube-system"
  }
}

module "gitlab" {
  source         = "../../../modules/gitlab"
  gitlab_project = "13886944"
  gitlab_ci_vars = {
    SERVER                     = "https://${data.terraform_remote_state.local_tfstate.outputs.cluster_name.endpoint}"
    CERTIFICATE_AUTHORITY_DATA = data.terraform_remote_state.local_tfstate.outputs.cluster_name.master_auth[0].cluster_ca_certificate
    USER_TOKEN = data.kubernetes_secret.gitlab_token.data.token
  }
}
