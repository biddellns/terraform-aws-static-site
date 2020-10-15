# Minimal Static Site

Configuration in this directory creates set of static site resources. It does not use a custom domain name and uses the Cloudfront hostname. This is generally only good for staging / testing environments. (look into [standard-site](../standard) for a more complete setup).

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Cloudfront, Lambda, for example). Run `terraform destroy` when you don't need these resources.