variable "domain_name" {
  description = "The domain name to be registered"
  type        = string
}

# variable "default_tags" {
#   description = "tags for environment"
#   type        = map(any)
# }

variable "record_type" {
  description = "type of the reocrd to be used"
  type        = string
}
