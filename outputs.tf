output "cdn_arn" {
  value       = var.enabled ? aws_cloudfront_distribution.cdn[0].arn : ""
  description = "Arn of Cloudfront Distribution serving the static site."
}

output "cdn_domain_name" {
  value       = var.enabled ? aws_cloudfront_distribution.cdn[0].domain_name : ""
  description = "URL of Cloudfront Distribution serving the static site."
}
output "s3_bucket_arn" {
  value       = var.enabled ? aws_s3_bucket.static_site[0].arn : ""
  description = "ARN of S3 bucket holding the site html/css/js and other assets."
}

output "index_html_rewriter_lambda" {
  value       = var.enabled ? aws_lambda_function.index_html[0].arn : ""
  description = "ARN of Lambda ensuring urls end in /index.html if no filename is in request"
}

output "ci-user" {
  value       = var.enabled ? aws_iam_user.static-site-ci[0].arn : ""
  description = "ARN of user with IAM permissions to sync files with s3_bucket"
}