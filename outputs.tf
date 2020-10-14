output "cdn" {
  value       = var.enabled ? aws_cloudfront_distribution.cdn[0] : ""
  description = "Cloudfront Distribution serving the static site."
}

output "s3_bucket" {
  value       = var.enabled ? aws_s3_bucket.static_site[0] : ""
  description = "S3 bucket holding the site html/css/js and other assets."
}

output "index_html_rewriter_lambda" {
  value       = var.enabled ? aws_lambda_function.index_html[0] : ""
  description = "Lambda ensuring urls end in /index.html if no filename is in request"
}

output "ci-user" {
  value       = var.enabled ? aws_iam_user.static-site-ci[0] : ""
  description = "User with IAM permissions to sync files with s3_bucket"
}