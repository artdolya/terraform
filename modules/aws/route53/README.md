# HOW TO

## No certificate

```hcl
module "example_com" {
  source             = "git@github.com:artdolya/terraform.git//modules/aws/route53"
  domain_name        = "example.com"
  # tags             = if required
}
```

## With certificate

```hcl
module "example_com" {
  source             = "git@github.com:artdolya/terraform.git//modules/aws/route53"
  domain_name        = "example.com"
  # tags             = if required
  create_certificate = true
  subject_alternative_names = [
    "*.example.com",
  ]
}
```