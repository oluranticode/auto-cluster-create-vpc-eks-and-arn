variable "install_argocd" {
    type = bool
    description = "if to install argocd or not"
}

variable "install_ingress_nginx" {
    type = bool
    description = "if to install ingress or not"
}

variable "domain_name" {
  description = "The domain name to be registered"
  type        = string
}

variable "cluster_name" {
    type = string
    description = "name of the cluster to be created"
  
}