# This module allows you to manage your Cloudflare DNS records.

## How to use this module

If your domain is managed externally you should create a new zone first including DNS records, and then you can you can create Email rules and forwardings.

Use NS type as a key for the records map.
Full list of NS types you can find [here](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record#type)

### Example

```hcl
module "cloudflare_zone_dolya_net" {
  source = "git::https://github.com/artdolya/terraform.git//modules/cloudflare/zone"

  domain_name = "example.com"
  account_id  = ACCOUNT_ID_FROM_CLOUDFLARE

  records = {
    NS = {
      aws = ["aws-ns1.example.com", "aws-ns2.example.com"]
    }
    A = {
      www = ["192.168.1.1"]
      some = ["10.0.0.1"]
    }
    CNAME = {
      blog = ["blog.github.io."]
      other = ["other.example.com."]
    }
    ...
  }

  email = {
    catch_all = "my.email@example.com"
    forwardings = {
      "info"     = "info@example.com"
      "support"     = "support@example.com"
    }
  }
}
```
