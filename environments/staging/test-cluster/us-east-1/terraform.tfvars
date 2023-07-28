# Generic Variables
region      = "eu-west-3"
domain_name = "f4b-stores-digital-product.com"
record_type = "CNAME"

#VPC variables
vpc_name        = "staging-vpc"
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
subnet_ids      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
cidr_block      = "10.0.0.0/16"
azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]

# Node/cluster variables
cluster_name       = "staging-test-cluster"
min_size           = 1
desired_size       = 1
max_size           = 2
instance_type      = ["m4.large"]
enable_nat_gateway = true
node_group_name    = "node_group-1"

#Tags
default_tags = {
  Environment      = "dev"
  Terraform        = true
  Owner            = "DevOps"
  certificate_name = "auto_cert"
}