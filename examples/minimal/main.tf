module "test_site" {
  source  = "biddellns/static-site/aws"
  version = "v1.x.x"

  enabled = true

  bucket_name = "domainless-website"
  ci_username = "domainless-website-ci"
}