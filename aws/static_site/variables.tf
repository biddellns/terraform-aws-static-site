variable "bucket_name" {
  type = string
  description = "Name of S3 bucket for static assets"
}

variable "provisioner" {
  type = string
  default = "Terraform"
  description = "Who/what provisioned a resource"
}

variable "cert_arn" {
  type = string
  description = "ARN of ACM cert for cloudfront. Needed until ported to terraform"
  default = ""
}

variable "default_root_object" {
  type = string
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  default = "index.html"
}

variable "cloudfront_cname_aliases" {
  type = list(string)
  description = "List of alternate CNAMEs for cdn"
  default = []
}

variable "ci_username" {
  type = string
  description = "Username for CI user for syncing s3 files"
  default = ""
}

variable "default_cache_time" {
  type = number
  description = "Default (and currently max) TTL in seconds"
  default = 86400 // 24 hours
}

variable "enabled" {
  type = bool
  description = "Whether or not the resources for this module should be created"
  default = false
}