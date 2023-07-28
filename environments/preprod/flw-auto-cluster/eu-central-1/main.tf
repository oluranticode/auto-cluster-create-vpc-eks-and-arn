####################################
#        EU-CENTRAL-1 RESOURCES    #
####################################

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "3.19.0"
  name               = var.vpc_name
  cidr               = var.cidr_block
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  tags               = var.default_tags
}

module "eks_mod" {
  source          = "../../../../modules/eks/"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  node_group_name = var.node_group_name
  instance_type   = var.instance_type
  min_size        = var.min_size
  desired_size    = var.desired_size
  max_size        = var.max_size
  ami_type        = var.ami_type
  disk_size       = var.disk_size
  tags            = var.default_tags
}


module "acm" {
  source      = "../../../../modules/acm/"
  domain_name = var.domain_name
  record_type = var.record_type
  # tags        = var.default_tags
}


