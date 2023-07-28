output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks_cluster.cluster_name
}
# output "region" {
#   value = data.aws_region.current.name
# }
output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}
output "cluster_ca_certificate" {
  value = module.eks_cluster.cluster_certificate_authority_data
}
output "eks_token" {
  value = data.aws_eks_cluster_auth.eks_cluster.token
}
output "environment" {
  value = var.environment
}