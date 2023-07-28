# Generic Variables
region             = "eu-central-1"
domain_name        = "flw-auto-cluster.com"
elb_name           = "test-elb"
record_type        = "CNAME"
vpc_name           = "auto-clustervpc"
cluster_name       = "Flw-auto-cluster"
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]
subnet_ids         = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
cidr_block         = "10.0.0.0/16"
azs                = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
min_size           = 2
desired_size       = 3
max_size           = 5
instance_types     = ["t3.micro"]
enable_nat_gateway = true
node_group_name    = "node_group-1"
default_tags = {
  Environment = "dev"
  Terraform   = true
  Owner       = "DevOps"
}




