# terraform-aws-static-site
A terraform module for generating secure static site infrastructure in AWS.

Design decisions detailed here: https://nicbiddell.com/blog/cloudfront-private-s3-and-gatsby/

## Benefits
- Served by Cloudfront CDN
- Seals off public access to your underlying S3 bucket
- Adds index.html as an index object. Solves the weird problem that Gatsby and other static site generators have with cloudfront!

## Providers

| Name | Version |
|------|---------|
| archive | 2.0 |
| aws | \>= 3.10, \< 4.0|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | Name of S3 bucket for static assets | `string` | n/a | yes |
| cert\_arn | ARN of ACM cert for cloudfront. If not provided, default Cloudfront cert will be used | `string` | `""` | no |
| ci\_username | Username for CI user for syncing s3 files | `string` | n/a | yes |
| cloudfront\_cname\_aliases | List of alternate CNAMEs for cdn | `list(string)` | `[]` | no |
| default\_cache\_time | Default (and currently max) TTL in seconds | `number` | `86400` | no |
| enabled | Whether or not the resources for this module should be created | `bool` | `false` | no |
| provisioner | Who/what provisioned a resource | `string` | `"Terraform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cdn\_arn | Arn of Cloudfront Distribution serving the static site. |
| cdn\_domain\_name | URL of Cloudfront Distribution serving the static site. |
| ci\_user | ARN of user with IAM permissions to sync files with s3\_bucket |
| index\_html\_rewriter\_lambda | ARN of Lambda ensuring urls end in /index.html if no filename is in request |
| s3\_bucket\_arn | ARN of S3 bucket holding the site html/css/js and other assets. |
