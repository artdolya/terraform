# HOW TO

## No certificate

```hcl
module "ssl_cert" {
  source = "../acm"
  count  = var.create_certificate ? 1 : 0

  domain_name               = "example.com"
  subject_alternative_names = ["www.example.com", "*.example.com"]
  validation_method         = "DNS"
  zone_id                   = "some zone id"
  # tags                    = if required
}
```