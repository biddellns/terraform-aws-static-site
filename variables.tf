variable "bucket_name" {
  type        = string
  description = "Name of S3 bucket for static assets"
}

variable "provisioner" {
  type        = string
  default     = "Terraform"
  description = "Who/what provisioned a resource"
}

variable "cert_arn" {
  type        = string
  description = "ARN of ACM cert for cloudfront. If not provided, default Cloudfront cert will be used"
  default     = ""
}

variable "cloudfront_cname_aliases" {
  type        = list(string)
  description = "List of alternate CNAMEs for cdn"
  default     = []
}

variable "ci_username" {
  type        = string
  description = "Username for CI user for syncing s3 files"
}

variable "default_cache_time" {
  type        = number
  description = "Default (and currently max) TTL in seconds"
  default     = 86400 // 24 hours
}

variable "enabled" {
  type        = bool
  description = "Whether or not the resources for this module should be created"
  default     = false
}