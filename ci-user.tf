resource "aws_iam_user" "static-site-ci" {
  count = var.enabled ? 1 : 0
  name  = var.ci_username
}

data "aws_iam_policy_document" "static-site-ci" {
  count = var.enabled ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.static_site[0].arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.static_site[0].arn
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "cloudfront:CreateInvalidation"
    ]
    resources = [
      aws_cloudfront_distribution.cdn[0].arn
    ]
  }
}

resource "aws_iam_policy" "static-site-ci" {
  count = var.enabled ? 1 : 0

  description = "For putting or deleting objects in personal site"
  name        = "Sync-Personal-Site"
  policy      = data.aws_iam_policy_document.static-site-ci.json
}

resource "aws_iam_user_policy_attachment" "static-site-ci" {
  count = var.enabled ? 1 : 0

  policy_arn = aws_iam_policy.static-site-ci[0].arn
  user       = aws_iam_user.static-site-ci[0].name
}