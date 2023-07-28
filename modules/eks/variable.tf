variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "The CIDR block that the node groups would be deployed in. (privatesubnet)."
}


variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "cluster_version" {
  description = "Version of the cluster"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group one"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the instances"
  type        = list(string)
  default     = ["m6in.large"]
}

variable "min_size" {
  description = "Minimum size of the node group"
  type        = number
}

variable "ami_type" {
  description = "AMI type ti be used to create the instance"
  type        = string
}

variable "desired_size" {
  description = "Desired size of the node group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the node group"
  type        = number
}

variable "disk_size" {
  description = "Size of the disk"
  type        = number
}

# variable "aws_auth_roles" {
#   description = "AWS authentication roles"
#   type        = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))
# }

variable "tags" {
  description = "Additional tags for the resources"
  type        = map(string)
}


####################
## Cluster Addons ##
####################

variable "coredns" {
  type = object({
    resolve_conflicts = string
    addon_version     = string
  })

  default = {
    addon_version     = "v1.8.7-eksbuild.3"
    resolve_conflicts = "OVERWRITE"
  }
}

variable "kube-proxy" {
  type = object({
    resolve_conflicts = string
    addon_version     = string
  })

  default = {
    addon_version     = "v1.25.6-eksbuild.2"
    resolve_conflicts = "OVERWRITE"
  }
}
variable "vpc-cni" {
  type = object({
    resolve_conflicts = string
    addon_version     = string
  })

  default = {
    addon_version     = "v1.13.0-eksbuild.1"
    resolve_conflicts = "OVERWRITE"
  }
}
variable "aws-ebs-csi-driver" {
  type = object({
    resolve_conflicts = string
    addon_version     = string
  })

  default = {
    addon_version     = "v1.13.0-eksbuild.2"
    resolve_conflicts = "OVERWRITE"
  }
}
# variable "adot" {
#   type = object({
#     resolve_conflicts = string
#     addon_version     = string
#   })

#   default = {
#     addon_version     = "v0.66.0-eksbuild.1"
#     resolve_conflicts = "OVERWRITE"
#   }
# }

variable "cluster_endpoint_private_access" {
  type    = bool
  default = true
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "environment" {
  type    = string
  default = "dev"  # Adjust the default value as needed
}
