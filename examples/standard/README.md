# Standard Static Site

Configuration in this directory creates set of static site resources that uses a custom domain name / SSL Certificate (look into [minimal-site](../minimal) for a more simplified setup).

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Cloudfront, Lambda, for example). Run `terraform destroy` when you don't need these resources.