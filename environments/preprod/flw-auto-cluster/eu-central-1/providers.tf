
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }

    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.8.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
variable "gitlab_token" {}
variable "gitlab_url" {}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = var.gitlab_url
}
provider "aws" {
  region = var.region
  # profile                 = "default"
  # shared_credentials_file = "~/.aws/credentials"
  allowed_account_ids = ["326355388919"]

  assume_role {
    role_arn = "arn:aws:iam::326355388919:role/terraform-cloud"
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_mod.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_mod.cluster_ca_certificate)
    token                  = module.eks_mod.eks_token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks_mod.cluster_name]
      command     = "aws"
    }
  }
}
provider "kubernetes" {
  host                   = module.eks_mod.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_mod.cluster_ca_certificate)
  token                  = module.eks_mod.eks_token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_mod.cluster_name]
    command     = "aws"
  }
}
provider "kubectl" {
  host                   = module.eks_mod.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_mod.cluster_ca_certificate)
  token                  = module.eks_mod.eks_token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks_mod.cluster_name]
    command     = "aws"
  }
}
