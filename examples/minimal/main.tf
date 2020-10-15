module "minimal_site" {
  source  = "../.."

  enabled = true

  bucket_name = "minimal-static-site"
  ci_username = "minimal-static-site-ci"
}