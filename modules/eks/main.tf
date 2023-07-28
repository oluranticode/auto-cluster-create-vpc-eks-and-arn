
# locals {
#   name   = "eks_mod"
# }

# resource "kubernetes_manifest" "secops_role" {
#   depends_on = [
#     module.eks_cluster
#   ]
#   manifest = yamldecode(file("${path.module}/roles/secops_role.yaml"))
# }

module "eks_cluster" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "19.7.0"
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  manage_aws_auth_configmap       = true
  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::326355388919:role/AWSReservedSSO_DevOps_DevEnv_78b26488f6bc173b"
      username = "SSO_DevOps_ProdEnv"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::326355388919:role/AWSReservedSSO_SecOps_Admin_c92203b621625637"
      username = "SSO_SecOps_DevEnv"
      groups   = ["secops-admin"]
    }
  ]

  cluster_addons = {
    coredns = {
      resolve_conflicts = var.coredns.resolve_conflicts
      addon_version     = var.coredns.addon_version
    }
    kube-proxy = {
      resolve_conflicts = var.kube-proxy.resolve_conflicts
      addon_version     = var.kube-proxy.addon_version
    }
    vpc-cni = {
      resolve_conflicts = var.vpc-cni.resolve_conflicts
      addon_version     = var.vpc-cni.addon_version
    }
    aws-ebs-csi-driver = {
      resolve_conflicts = var.aws-ebs-csi-driver.resolve_conflicts
      addon_version     = var.aws-ebs-csi-driver.addon_version
    }
    # adot = {
    #   resolve_conflicts = var.adot.resolve_conflicts
    #   addon_version     = var.adot.addon_version
    # }
  }
  eks_managed_node_group_defaults = {
    ami_type       = var.ami_type
    disk_size      = var.disk_size
    instance_type = var.instance_type #["r6i.4xlarge"]
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
    pre_bootstrap_user_data = <<-EOT
    sudo yum install -y
    curl -sLO https://flw-sentinel.s3.eu-west-1.amazonaws.com/s1-agent-helper-ec2-image-builder.sh
    chmod +x s1-agent-helper-ec2-image-builder.sh
    ./s1-agent-helper-ec2-image-builder.sh
    EOT
    labels = {
      Environment  = "${var.environment}"
      "managed_by" = "terraform"
    }
    tags = {
      Environment                                     = "${var.environment}"
      Terraform                                       = "true"
      Owner                                           = "DevOps"
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"             = "true"
    }
  }

  eks_managed_node_groups = {
    node-group-1 = {
      name         = var.node_group_name # "node-group-1"
      min_size     = var.min_size        # 1, 10, 6
      max_size     = var.max_size
      desired_size = var.desired_size
    }
  }

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    ingress_cluster_control_plane = {
      description                   = "From Control plane security group"
      protocol                      = "tcp"
      from_port                     = 1025
      to_port                       = 65535
      type                          = "ingress"
      source_cluster_security_group = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks_cluster.cluster_name
}
# data "aws_region" "current" {
#   name = module.eks_cluster.cluster_name
# }
