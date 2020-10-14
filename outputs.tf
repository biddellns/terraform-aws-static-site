output "portfolio_cloudfront_url" {
  value = var.enabled ? aws_cloudfront_distribution.cdn[0].domain_name : ""
}