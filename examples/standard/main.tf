module "blog_site" {
  source  = "biddellns/static-site/aws"
  version = "v1.x.x"

  enabled = true

  bucket_name              = "yoursite.com"
  cloudfront_cname_aliases = ["yoursite.com"]
  cert_arn                 = " arn:aws:acm:region-x:000000000000:certificate/2e36b007-6eeb-4f84-82b6-b15d755bf002"
  ci_username              = "yoursite-circleci-user"

  default_cache_time       = 7776000 // 90 days
}