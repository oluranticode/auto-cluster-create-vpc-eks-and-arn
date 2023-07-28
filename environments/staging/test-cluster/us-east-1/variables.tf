# # space

variable "private_subnets" {
  description = "ID for the private subnet"
  type        = list(string)
}

variable "public_subnets" {
  description = "ID for the public subnet"
  type        = list(string)
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "subnet_ids" {
  type        = list(string)
  description = "The CIDR block for subnets."
}

variable "azs" {
  type        = list(string)
  description = "The availability zones for the VPC e.g ['us-west-2a', 'us-west-2b', 'us-west-2c']."
}


variable "default_tags" {
  description = "tags for environment"
  type        = map(any)
}

variable "cluster_name" {
  description = "name of the cluster to be setup"
  type        = string
}

variable "domain_name" {
  description = "The domain name to be registered"
  type        = string
}

# variable "elb_name" {
#   description = "name of the elastic load balancer"
#   type        = string
# }
variable "vpc_name" {
  description = "name of the vpc to be created"
  type        = string
}

variable "record_type" {
  description = "type of the reocrd to be used"
  type        = string
}

# variable "role" {
#     description = "value"

# }

# # variable "AWS_ACCESS_KEY_ID" {}
# # variable "AWS_SECRET_ACCESS_KEY" {
# #   sensitive = true
# # }


###########################
## EKS cluster resources ##
###########################

# variable "vpc_id" {
#   type = string
# }


variable "environment" {
  type    = string
  default = "dev"
}

variable "module_version" {
  type    = string
  default = "19.7.0"
}
variable "cluster_version" {
  type    = string
  default = "1.27"
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = true
}
variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "region" {
  type = string
}

variable "enable_nat_gateway" {
  type = bool
}

####################
## AWS ROLES ##
####################

variable "aws_auth_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = [
    {
      rolearn  = "arn:aws:iam::326355388919:role/AWSReservedSSO_DevOps_DevEnv_78b26488f6bc173b"
      username = "SSO_DevOps_DevEnv"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::326355388919:role/AWSReservedSSO_SecOps_Admin_c92203b621625637"
      username = "SSO_SecOps_DevEnv"
      groups   = ["secops-admin"]
    }
  ]
}



####################
##   node group   ##
####################

variable "ami_type" {
  type    = string
  default = "AL2_x86_64"
}
variable "disk_size" {
  type    = number
  default = 100
}

variable "instance_type" {
  description = "The instance type for the instances"
  type        = list(string)
  default     = ["m4.large"]
}

variable "node_group_name" {
  type = string
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "desired_size" {
  type = number
}