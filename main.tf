resource "aws_s3_bucket" "static_site" {
  count = var.enabled ? 1 : 0

  acl    = "private"
  bucket = var.bucket_name


  tags = {
    Provisioner = var.provisioner
  }
}

resource "aws_s3_bucket_public_access_block" "static_site" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.static_site[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "static_site" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.static_site[0].id
  policy = data.aws_iam_policy_document.static_site[0].json
}

data "aws_iam_policy_document" "static_site" {
  count = var.enabled ? 1 : 0

  statement {
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.static_site[0].arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.static_site_s3[0].iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.static_site[0].arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.static_site_s3[0].iam_arn]
    }
  }
}

resource "aws_cloudfront_distribution" "cdn" {
  count = var.enabled ? 1 : 0

  enabled = true

  aliases = var.cloudfront_cname_aliases

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = "S3-${aws_s3_bucket.static_site[0].bucket_regional_domain_name}"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.index_html[0].qualified_arn
    }

    default_ttl = var.default_cache_time
    max_ttl     = var.default_cache_time
    min_ttl     = 0
  }
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  origin {
    domain_name = aws_s3_bucket.static_site[0].bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.static_site[0].bucket_regional_domain_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.static_site_s3[0].cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cert_arn == "" ? true : false
    acm_certificate_arn            = var.cert_arn
    minimum_protocol_version       = "TLSv1.2_2019"
    ssl_support_method             = "sni-only"
  }

  tags = {
    Provisioner = var.provisioner
  }
}


resource "aws_cloudfront_origin_access_identity" "static_site_s3" {
  count = var.enabled ? 1 : 0

  comment = "static_site_s3"
}

resource "aws_lambda_function" "index_html" {
  count = var.enabled ? 1 : 0

  filename      = data.archive_file.dummy[0].output_path
  function_name = "${aws_cloudfront_distribution.cdn.id}-index-html-writer"
  handler       = "exports.handler"
  role          = aws_iam_role.lambda_edge_exec[0].arn
  runtime       = "nodejs12.x"
  publish       = true

  tags = {
    Provisioner = var.provisioner
  }
}

resource "aws_iam_role" "lambda_edge_exec" {
  count = var.enabled ? 1 : 0

  assume_role_policy = data.aws_iam_policy_document.lambda-at-edge[0].json

  tags = {
    Provisioner = var.provisioner
  }
}

data "aws_iam_policy_document" "lambda-at-edge" {
  count = var.enabled ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }
  }
}

data "archive_file" "dummy" {
  count = var.enabled ? 1 : 0

  output_path = "${path.module}/lambda_function_code.zip"
  type        = "zip"

  source {
    content  = "console.log('Hello World');"
    filename = "exports.js"
  }
}