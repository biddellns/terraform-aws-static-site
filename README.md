# terraform-aws-static-site
A terraform for generating a static site with AWS.

## Benefits
- Served by Cloudfront CDN
- Seals off public access to your underlying S3 bucket
- Adds index.html as an index object. Solves the weird problem that Gatsby and other static site generators have with cloudfront!


