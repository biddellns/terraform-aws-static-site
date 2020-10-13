output "portfolio_cloudfront_url" {
  value = aws_cloudfront_distribution.cdn[0].domain_name
}