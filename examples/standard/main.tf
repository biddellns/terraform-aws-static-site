module "standard_site" {
  source  = "../.."

  enabled = true

  bucket_name              = "standard-static-site.com"
  cloudfront_cname_aliases = ["standard-static-site.com"]
  cert_arn                 = var.cert_arn
  ci_username              = "standard-static-site-ci"

  default_cache_time       = 7776000 // 90 days
}